locals {
  availability_zone_abbreviation = {
    "a" = "az1"
    "b" = "az2"
    "c" = "az3"
  }
  region_abbreviation = {
    "us-east-1" = "e1"
  }
  account_abbreviation = {
    991969831119 = "sb"
    609525944595 = "rw"
    947717610669 = "ci"
    307327793073 = "ut"
    356617482454 = "rc"
    785076400572 = "pd"
    167223888864 = "pm"
    282178918024 = "nw"
    569467453343 = "sc"
    "001104824186" = "ad"
  }

  bdm = {
    for device in data.aws_ami.this.block_device_mappings :
    device.device_name => device.ebs
    if device.device_name != "/dev/sda1" && device.device_name != "/dev/xvda" && !startswith(device.virtual_name, "ephemeral")
  }
  inputOnly = setsubtract(keys(var.ebs_block_devices), keys(local.bdm))
  inputOnlym = {
    for device in local.inputOnly :
    device => var.ebs_block_devices[device]
  }
  amiOnly = setsubtract(keys(local.bdm), keys(var.ebs_block_devices))
  amiOnlym = {
    for device in local.amiOnly :
    device => local.bdm[device]
  }
  both = setintersection(keys(local.bdm), keys(var.ebs_block_devices))
  bothm = {
    for device in local.both :
    device => merge(local.bdm[device], var.ebs_block_devices[device])
    if lookup(var.ebs_block_devices[device], "deleted", false) == null ? true : false
  }
  m = local.inputOnly == local.both ? tomap({}) : merge(local.inputOnlym, local.amiOnlym, local.bothm)
}