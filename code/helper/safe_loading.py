import json
import yaml


def load_json_content_safely(template_content, source):
    try:
        return json.loads(template_content)
    except Exception as e:
        if source == "CFN":
            raise yaml.YAMLError(f"There is an error when loading the CFN template: {str(e)}")
        else:
            raise Exception(f"There is an error when loading the template: {str(e)}")