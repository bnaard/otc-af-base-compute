##################################################################################
## General
##################################################################################

variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}

variable "name" {
  type        = string
  default     = "otc_ecs"
  description = "Name of virtual machine (default: \"otc_ecs\")"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the virtual machine. Format: \"{ key1 = \"value1\", key2 = \"value2\" ...} \" (default: n/a)."
}

variable "cloud_init_config" {
  description = "Cloud-init configuration (multi-line string) used as user-data (default: \"\").\nTo add own cloud-init files use a local variable to ceate a list of paths each containing cloud-init files:\n  locals {\n    cloud_init_files = flatten([\n      for path_to_cloud_init in <your_list_of_paths_to_cloud_init_files> : [\n        for path in fileset(\"\", \"\${path_to_cloud_init}/*.{yml,yaml}\") : path\n      ]\n    ])\n  }\nThen add the file-contents to this variable with a join-statement:\n  cloud_init_config = join(\"\\n\", [for filepath in local.cloud_init_files : file(filepath)])"
  type        = string
  default     = ""
}

##################################################################################
## Virtual machine configuration
##################################################################################

variable "availability_zone" {
  type        = string
  description = "Availability zone for the virtual machine (default: \"eu-de-01\")"
  default     = "eu-de-01"
}

variable "flavor_name" {
  type        = string
  default     = "s3.medium.1"
  description = "Name of the compute ressource type. Valid values see https://open-telekom-cloud.com/service-description, page 9  (default: \"s3.medium.1\")"
}

variable "image_name" {
  type        = string
  default     = "Standard_Ubuntu_22.04_latest"
  description = "Name of the OTC source image (default: \"Standard_Ubuntu_22.04_latest\")"
}


variable "subnet_id" {
  type        = string
  description = "ID of subnet this virtual machine belongs to (default: n/a)."
}




##################################################################################
## Emergency user
##################################################################################

variable "emergency_user" {
  description = "If set to *true*, a cloud-init config with an *emergency_ssh_key' for *emergency_user_spec* will be added (default: false)."
  type        = bool
  default     = false
}

variable "emergency_user_spec_username" {
  description = "This variable represents the username for an emergency user (default: \"emergency\")."
  type = string
  default = "emergency"
}

variable "emergency_user_spec_groups" {
  description = "This variable represents the groups that the emergency user belongs to (default: \"[\"users\", \"admin\", \"wheel\"]\")."
  type = list(string)
  default = ["users", "admin", "wheel"]
}

variable "emergency_user_spec_shell" {
  description = "This variable represents the shell that the emergency user will use (default: \"/bin/sh\")."
  type = string
  default = "/bin/sh"
}

variable "emergency_user_spec_sudo" {
  description = "This variable represents the sudo permissions for the emergency user (default: \"ALL=(ALL) NOPASSWD:ALL\")."
  type = string
  default = "ALL=(ALL) NOPASSWD:ALL"
}

variable "emergency_user_spec_public_key_file" {
  description = "This variable represents the public key file for the emergency user (default: empty string)."
  type = string
  default = ""
}


##################################################################################
## Security
##################################################################################

variable "allow_tcp_forwarding" {
  description   = "Enables (true) or disables (false) TCP forwarding, e.g. for using the virtual machine as jump host (default: false)"
  type          = bool
  default       = false
}
