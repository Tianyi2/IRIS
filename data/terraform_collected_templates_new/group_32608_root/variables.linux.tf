variable "admin_ssh_keys" {
  type = list(object({
    public_key = string
    username   = string
  }))
  default     = []
  description = <<ADMIN_SSH_KEYS
A list of objects defining one or more ssh public keys

- `public_key` (Required) - The Public Key which should be used for authentication, which needs to be at least 2048-bit and in `ssh-rsa` format. Changing this forces a new resource to be created.
- `username` (Required) - The Username for which this Public SSH Key should be configured. Changing this forces a new resource to be created. The Azure VM Agent only allows creating SSH Keys at the path `/home/{admin_username}/.ssh/authorized_keys`. As such this public key will be written to the authorized keys file. If no username is provided this module will use var.admin_username.

Example Input:

```hcl
admin_ssh_keys = [
  {
    public_key = "<base64 string for the key>"
    username   = "exampleuser"
  },
  {
    public_key = "<base64 string for the next user key>"
    username   = "examleuser2"
  }
]
```
  ADMIN_SSH_KEYS
}

variable "disable_password_authentication" {
  type        = bool
  default     = true
  description = "If true this value will disallow password authentication on linux vm's. This will require at least one public key to be configured. If using the option to auto generate passwords and keys, setting this value to `false` will cause a password to be generated an stored instead of an SSH key."
}