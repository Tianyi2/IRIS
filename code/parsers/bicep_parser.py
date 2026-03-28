import os
import subprocess
import tempfile
import shutil
import platform
from typing import Dict, Any, Optional
from parsers.arm_parser import ARMParser


class BicepParser:
    def __init__(self, template_path: str):
        self.template_path = template_path
        self.temp_arm_file = None
        self.az_cli_path = self._find_azure_cli()
    
    def _find_azure_cli(self) -> Optional[str]:
        """
        Find Azure CLI executable path.
        Checks common installation locations on Windows and PATH.
        Returns the full path to 'az' or 'az.cmd', or None if not found.
        """
        # First, try to find 'az' in PATH using shutil.which
        # This works even in virtual environments if az is in system PATH
        az_path = shutil.which('az')
        if az_path:
            return az_path
        
        # On Windows, also try 'az.cmd'
        if platform.system() == 'Windows':
            az_cmd_path = shutil.which('az.cmd')
            if az_cmd_path:
                return az_cmd_path
            
            # Check common Azure CLI installation paths on Windows
            common_paths = [
                r"C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd",
                r"C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd",
                r"C:\Program Files\Azure CLI\az.cmd",
                os.path.expanduser(r"~\AppData\Local\Programs\Azure CLI\az.cmd"),
            ]
            
            for path in common_paths:
                if os.path.exists(path):
                    return path
        
        return None
    
    def parse(self) -> Optional[Dict[str, Any]]:
        """
        Parse Bicep template and return structured information.
        Converts Bicep to ARM JSON first, then uses ARMParser to parse it.
        """
        try:
            # 1. Convert Bicep to ARM JSON
            arm_json_path = self.convert_bicep_to_arm()
            if not arm_json_path:
                return None
            
            # 2. Parse the ARM template using ARMParser
            arm_parser = ARMParser(arm_json_path)
            parsed_data = arm_parser.parse()
            
            # 3. Update metadata to reflect that this is a Bicep template
            if parsed_data and 'metadata' in parsed_data:
                parsed_data['metadata']['template_type'] = 'Bicep'
                # Keep the original Bicep file name
                parsed_data['metadata']['file_name'] = os.path.basename(self.template_path)
            
            # 4. Clean up temporary file
            self.cleanup_temp_file()
            
            # 5. Return the parsed template
            return parsed_data

        # Comment out below code for dataset evaluation
        # except Exception as e:
        #     print(f"Error parsing Bicep template: {str(e)}")
        #     return None

        finally:
            # Clean up temporary file even if there's an error
            self.cleanup_temp_file()
    
    def convert_bicep_to_arm(self) -> Optional[str]:
        """
        Convert Bicep file to ARM JSON format using Azure CLI.
        Returns the path to the temporary ARM JSON file, or None on error.
        """
        try:
            # Get absolute path of Bicep file
            bicep_abs_path = os.path.abspath(self.template_path)
            
            # Verify the Bicep file exists
            if not os.path.exists(bicep_abs_path):
                print(f"Error: Bicep file not found: {bicep_abs_path}")
                return None
            
            # Create a temporary file for the ARM JSON output
            # Use the same directory as the Bicep file to avoid permission issues
            bicep_dir = os.path.dirname(bicep_abs_path) or os.getcwd()
            
            # Create temp file in the same directory as the Bicep file
            temp_fd, temp_path = tempfile.mkstemp(suffix='.json', prefix='bicep_arm_', dir=bicep_dir)
            os.close(temp_fd)  # Close the file descriptor, we'll use the path
            self.temp_arm_file = temp_path
            
            # Check if Azure CLI is available
            if not self.az_cli_path:
                print("Error: Azure CLI (az) not found.")
                print("Please install Azure CLI from https://aka.ms/installazurecliwindows")
                print("Or ensure 'az' is in your system PATH.")
                return None
            
            # Run az bicep build command
            # Command: az bicep build --file {bicep_file} --outfile {out_file}
            cmd = [
                self.az_cli_path,
                'bicep',
                'build',
                '--file', bicep_abs_path,
                '--outfile', temp_path
            ]
            
            # Execute the command
            # On Windows, when using .cmd files, we need to handle them properly
            # For paths with spaces, ensure proper quoting
            if platform.system() == 'Windows' and self.az_cli_path.endswith('.cmd'):
                # On Windows with .cmd files, use shell=True and pass as string
                # This ensures proper execution of batch files
                cmd_str = ' '.join(f'"{arg}"' if ' ' in str(arg) else str(arg) for arg in cmd)
                result = subprocess.run(
                    cmd_str,
                    capture_output=True,
                    text=True,
                    check=False,  # Don't raise exception on non-zero exit
                    shell=True
                )
            else:
                # For regular executables, use list format
                result = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    check=False  # Don't raise exception on non-zero exit
                )
            
            if result.returncode != 0:
                # print(f"Error converting Bicep to ARM: {result.stderr}")
                # print(f"Command: {' '.join(cmd)}")
                raise Exception(f"Error converting Bicep to ARM: {result.stderr}")
            
            # Verify the output file was created
            if not os.path.exists(temp_path):
                print(f"Error: ARM JSON file was not created at {temp_path}")
                return None
            
            return temp_path
            
        except FileNotFoundError:
            print("Error: Azure CLI executable not found at the expected path.")
            if self.az_cli_path:
                print(f"Attempted to use: {self.az_cli_path}")
            return None
    
    def cleanup_temp_file(self) -> None:
        """Clean up the temporary ARM JSON file if it exists."""
        if self.temp_arm_file and os.path.exists(self.temp_arm_file):
            try:
                os.remove(self.temp_arm_file)
            except Exception as e:
                print(f"Warning: Could not remove temporary file {self.temp_arm_file}: {str(e)}")
            finally:
                self.temp_arm_file = None

