## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.protected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_ebs_volume.unprotected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_instance.protected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.unprotected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.protected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_volume_attachment.unprotected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The id of the machine image (AMI) to use for the server. | `string` | n/a | yes |
| <a name="input_az"></a> [az](#input\_az) | az to build out the instance in. e.g. a,b,c,etc | `string` | n/a | yes |
| <a name="input_dedicated"></a> [dedicated](#input\_dedicated) | null, dedicated or host. dedicated = dedicated instance. host = a dedicated host. | `string` | `null` | no |
| <a name="input_device_tag_mapping"></a> [device\_tag\_mapping](#input\_device\_tag\_mapping) | n/a | `map` | `{}` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection. | `bool` | `true` | no |
| <a name="input_ebs_block_devices"></a> [ebs\_block\_devices](#input\_ebs\_block\_devices) | Additional EBS block devices to attach to the instance | <pre>map(<br>    object(<br>      {<br>        deleted               = optional(bool)<br>        volume_size           = optional(number)<br>        iops                  = optional(number)<br>        kms_key_id            = optional(string)<br>        volume_type           = optional(string)<br>        volume_size           = optional(number)<br>        iops                  = optional(number)<br>        delete_on_termination = optional(bool)<br>        encrypted             = optional(bool)<br>        throughput            = optional(number)<br>        snapshot_id           = optional(string)<br>        tags                  = optional(map(string))<br>      }<br>    )<br>  )</pre> | `{}` | no |
| <a name="input_ebs_default_settings"></a> [ebs\_default\_settings](#input\_ebs\_default\_settings) | the default values for all additional ebs block devices. the purpose of this is like for the dbs where you have 5 drives totall with all the same config except the size so you would just have to override the size in the default for that one drive and the rest use defaul config. | <pre>object({<br>    volume_type           = string<br>    kms_key_id            = optional(string)<br>    volume_size           = optional(number)<br>    iops                  = optional(number)<br>    delete_on_termination = optional(bool)<br>    encrypted             = optional(bool)<br>    throughput            = optional(number)<br>    }<br>  )</pre> | <pre>{<br>  "delete_on_termination": true,<br>  "encrypted": false,<br>  "iops": null,<br>  "kms_key_id": null,<br>  "throughput": null,<br>  "volume_size": 100,<br>  "volume_type": "gp3"<br>}</pre> | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized. | `bool` | `false` | no |
| <a name="input_ec2_name"></a> [ec2\_name](#input\_ec2\_name) | Part of the name appended before the sequence # | `string` | `""` | no |
| <a name="input_enable_public_ip"></a> [enable\_public\_ip](#input\_enable\_public\_ip) | Whether to associate a public IP address with an instance in a VPC. | `bool` | `false` | no |
| <a name="input_host_id"></a> [host\_id](#input\_host\_id) | n/a | `any` | `null` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | IAM Instance Profile to launch the instance with. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance; which can be managed using the aws\_key\_pair resource. | `string` | `null` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled. | `bool` | `true` | no |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | When set to true, will cause Terraform to reject with an error any plan that would destroy <br>the infrastructure object associated with the resource, <br>as long as the argument remains present in the configuration. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for the resource creation. This value is used for create the availability zone abbreviation | `string` | `"us-east-1"` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details | `map(any)` | `{}` | no |
| <a name="input_secondary_private_ips"></a> [secondary\_private\_ips](#input\_secondary\_private\_ips) | list of secondary\_private\_ips | `list(string)` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security group IDs to associate with. | `any` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | subnet prefix to build subnet in e.g. pub*,dat*,etc | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags for all resources | `map(any)` | n/a | yes |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Can be used instead of user\_data to pass base64-encoded binary data directly. | `string` | `""` | no |
| <a name="input_user_data_replace_on_change"></a> [user\_data\_replace\_on\_change](#input\_user\_data\_replace\_on\_change) | should a change in the userdata cause the instance to be destroyed? | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2"></a> [ec2](#output\_ec2) | EC2 attributees |
