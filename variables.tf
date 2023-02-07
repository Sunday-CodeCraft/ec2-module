variable "host_id" {
  default = null
}

variable "user_data_replace_on_change" {
  description = "should a change in the userdata cause the instance to be destroyed?"
  default     = true
  type        = bool
}

variable "security_group_ids" {
  default     = null
  description = "A list of security group IDs to associate with."
}

variable "dedicated" {
  description = "null, dedicated or host. dedicated = dedicated instance. host = a dedicated host."
  default     = null
  type        = string
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = {}
  type        = map(any)
}

variable "ebs_default_settings" {
  description = "the default values for all additional ebs block devices. the purpose of this is like for the dbs where you have 5 drives totall with all the same config except the size so you would just have to override the size in the default for that one drive and the rest use defaul config."
  type = object({
    volume_type           = string
    kms_key_id            = optional(string)
    volume_size           = optional(number)
    iops                  = optional(number)
    delete_on_termination = optional(bool)
    encrypted             = optional(bool)
    throughput            = optional(number)
    }
  )
  default = {
    volume_type           = "gp3"
    kms_key_id            = null
    volume_size           = 100
    iops                  = null
    delete_on_termination = true
    encrypted             = false
    throughput            = null
  }
}

variable "ebs_block_devices" {
  description = "Additional EBS block devices to attach to the instance"
  type = map(
    object(
      {
        deleted               = optional(bool)
        volume_size           = optional(number)
        iops                  = optional(number)
        kms_key_id            = optional(string)
        volume_type           = optional(string)
        volume_size           = optional(number)
        iops                  = optional(number)
        delete_on_termination = optional(bool)
        encrypted             = optional(bool)
        throughput            = optional(number)
        snapshot_id           = optional(string)
        tags                  = optional(map(string))
      }
    )
  )
  default = {}
}

variable "device_tag_mapping" {
  default = {}
}
variable "subnet_id" {
  description = "subnet prefix to build subnet in e.g. pub*,dat*,etc" #TODO feature to allow multiple subnets?
  type        = string
}
variable "secondary_private_ips" {
  description = "list of secondary_private_ips"
  type        = list(string)
  default     = null

}

variable "az" {
  description = "az to build out the instance in. e.g. a,b,c,etc"
  type        = string
}

variable "ami_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  validation {
    condition     = can(regex("^ami-", var.ami_id))
    error_message = "The ami_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "instance_type" {
  description = "The instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance."
  default     = "t2.micro"
  type        = string
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly."
  default     = ""
  type        = string
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource."
  default     = null
  type        = string
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
  default     = true
  type        = bool

}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  default     = false
  type        = bool
}

variable "iam_instance_profile" {
  description = " IAM Instance Profile to launch the instance with."
  default     = "" #should be "AmazonSSMRoleForInstances" once that role is created.
  type        = string
}

variable "enable_public_ip" {
  description = "Whether to associate a public IP address with an instance in a VPC."
  default     = false
  type        = bool
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection."
  default     = true
  type        = bool
}

# naming
variable "ec2_name" {
  description = "Part of the name appended before the sequence #"
  default     = ""
  type        = string
  #default yields "review-use1-az1-0002"
  #set to X yields "review-use1-az1-X0002"
}

variable "region" {
  description = "Region for the resource creation. This value is used for create the availability zone abbreviation"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  type        = map(any)
  description = "tags for all resources"
}

variable "prevent_destroy" {
  description = <<-DOC
    When set to true, will cause Terraform to reject with an error any plan that would destroy 
    the infrastructure object associated with the resource, 
    as long as the argument remains present in the configuration.
  DOC
  default     = true
  type        = bool
} 