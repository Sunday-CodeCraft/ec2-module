### TODO NEED TO DO KMS & Key pair
resource "aws_instance" "protected" {
  count = var.prevent_destroy ? 1 : 0

  tenancy                     = var.dedicated #== "instance" ? "dedicated" : "default"
  host_id                     = var.host_id
  ami                         = data.aws_ami.this.id
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  monitoring                  = var.monitoring
  instance_type               = var.instance_type
  ebs_optimized               = var.ebs_optimized
  user_data_base64            = var.user_data_base64
  user_data_replace_on_change = var.user_data_replace_on_change
  iam_instance_profile        = var.iam_instance_profile
  disable_api_termination     = var.disable_api_termination
  associate_public_ip_address = var.enable_public_ip
  vpc_security_group_ids      = var.security_group_ids
  secondary_private_ips       = var.secondary_private_ips
  tags = merge({ "Name" = format("%s%s-%s",
    local.region_abbreviation[var.region],
    local.account_abbreviation[data.aws_caller_identity.current.account_id],
    var.ec2_name) },
  var.tags)

  # Modifying any of the root_block_device settings other than volume_size or tags requires resource replacement.
  root_block_device {
    volume_type           = try(coalesce(var.root_block_device.volume_type), var.ebs_default_settings.volume_type)
    kms_key_id            = try(coalesce(var.root_block_device.kms_key_id), var.ebs_default_settings.kms_key_id)
    volume_size           = try(coalesce(var.root_block_device.volume_size), var.ebs_default_settings.volume_size)
    iops                  = try(coalesce(var.root_block_device.iops), var.ebs_default_settings.iops)
    throughput            = try(coalesce(var.root_block_device.throughput), var.ebs_default_settings.throughput)
    delete_on_termination = try(coalesce(var.root_block_device.delete_on_termination), var.ebs_default_settings.delete_on_termination)
    encrypted             = true
  }
  dynamic "ebs_block_device" {
    for_each = local.amiOnlym
    content {
      device_name           = ebs_block_device.key
      encrypted             = true
      volume_type           = try(coalesce(ebs_block_device.value.volume_type), var.ebs_default_settings.volume_type)
      kms_key_id            = try(coalesce(ebs_block_device.value.kms_key_id), var.ebs_default_settings.kms_key_id)
      volume_size           = try(coalesce(ebs_block_device.value.volume_size), var.ebs_default_settings.volume_size)
      iops                  = try(coalesce(ebs_block_device.value.iops), var.ebs_default_settings.iops)
      throughput            = try(coalesce(ebs_block_device.value.throughput), var.ebs_default_settings.throughput)
      delete_on_termination = try(coalesce(ebs_block_device.value.delete_on_terminatio), var.ebs_default_settings.delete_on_termination)
      snapshot_id           = try(coalesce(ebs_block_device.value.snapshot_id), null)
    }
  }
  volume_tags = merge({ "Name" = format("%s%s-%s",
    local.region_abbreviation[var.region],
    local.account_abbreviation[data.aws_caller_identity.current.account_id],
    var.ec2_name) },
  var.tags)

  lifecycle {
    ignore_changes = [
      user_data_base64,
      user_data,
    ]
    prevent_destroy = true
  }
}

resource "aws_instance" "unprotected" {
  count = var.prevent_destroy ? 0 : 1

  tenancy                     = var.dedicated #== "instance" ? "dedicated" : "default"
  host_id                     = var.host_id
  ami                         = data.aws_ami.this.id
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  monitoring                  = var.monitoring
  instance_type               = var.instance_type
  ebs_optimized               = var.ebs_optimized
  user_data_base64            = var.user_data_base64
  user_data_replace_on_change = var.user_data_replace_on_change
  iam_instance_profile        = var.iam_instance_profile
  disable_api_termination     = var.disable_api_termination
  associate_public_ip_address = var.enable_public_ip
  vpc_security_group_ids      = var.security_group_ids
  secondary_private_ips       = var.secondary_private_ips
  tags = merge({ "Name" = format("%s%s-%s",
    local.region_abbreviation[var.region],
    local.account_abbreviation[data.aws_caller_identity.current.account_id],
    var.ec2_name) },
  var.tags)

  # Modifying any of the root_block_device settings other than volume_size or tags requires resource replacement.
  root_block_device {
    volume_type           = try(coalesce(var.root_block_device.volume_type), var.ebs_default_settings.volume_type)
    kms_key_id            = try(coalesce(var.root_block_device.kms_key_id), var.ebs_default_settings.kms_key_id)
    volume_size           = try(coalesce(var.root_block_device.volume_size), var.ebs_default_settings.volume_size)
    iops                  = try(coalesce(var.root_block_device.iops), var.ebs_default_settings.iops)
    throughput            = try(coalesce(var.root_block_device.throughput), var.ebs_default_settings.throughput)
    delete_on_termination = try(coalesce(var.root_block_device.delete_on_termination), var.ebs_default_settings.delete_on_termination)
    encrypted             = true
  }
  dynamic "ebs_block_device" {
    for_each = local.amiOnlym
    content {
      device_name           = ebs_block_device.key
      encrypted             = true
      volume_type           = try(coalesce(ebs_block_device.value.volume_type), var.ebs_default_settings.volume_type)
      kms_key_id            = try(coalesce(ebs_block_device.value.kms_key_id), var.ebs_default_settings.kms_key_id)
      volume_size           = try(coalesce(ebs_block_device.value.volume_size), var.ebs_default_settings.volume_size)
      iops                  = try(coalesce(ebs_block_device.value.iops), var.ebs_default_settings.iops)
      throughput            = try(coalesce(ebs_block_device.value.throughput), var.ebs_default_settings.throughput)
      delete_on_termination = try(coalesce(ebs_block_device.value.delete_on_termination), var.ebs_default_settings.delete_on_termination)
      snapshot_id           = try(coalesce(ebs_block_device.value.snapshot_id), null)
    }
  }
  volume_tags = merge({ "Name" = format("%s%s-%s",
    local.region_abbreviation[var.region],
    local.account_abbreviation[data.aws_caller_identity.current.account_id],
    var.ec2_name) },
  var.tags)


  lifecycle {
    ignore_changes = [
      user_data_base64,
      user_data,
    ]
    prevent_destroy = false
  }
}

resource "aws_ebs_volume" "protected" {
  for_each = var.prevent_destroy ? toset(keys(local.m)) : toset(keys({}))

  availability_zone = data.aws_subnet.selected.availability_zone
  final_snapshot    = try(coalesce(local.m[each.value].final_snapshot), true)
  type              = try(coalesce(local.m[each.value].volume_type), var.ebs_default_settings.volume_type)
  kms_key_id        = try(coalesce(local.m[each.value].kms_key_id), var.ebs_default_settings.kms_key_id)
  size              = try(coalesce(local.m[each.value].volume_size), var.ebs_default_settings.volume_size)
  iops              = try(coalesce(local.m[each.value].iops), var.ebs_default_settings.iops)
  throughput        = try(coalesce(local.m[each.value].throughput), var.ebs_default_settings.throughput) == "0" ? null : try(coalesce(local.m[each.value].throughput), var.ebs_default_settings.throughput)
  encrypted         = true
  snapshot_id       = try(coalesce(local.m[each.value].snapshot_id), null)

  depends_on = [aws_instance.protected]
  tags = merge(
    { 
      "Name" = format("%s%s-%s",
      local.region_abbreviation[var.region],
      local.account_abbreviation[data.aws_caller_identity.current.account_id],
      var.ec2_name) 
    },
    var.tags,
    try(var.device_tag_mapping[each.key], tomap({ "drive" = "unknown" })),
    try(each.value.tags, {})
  )
}

resource "aws_volume_attachment" "protected" {
  for_each = aws_ebs_volume.protected

  device_name = each.key #each.value.tags.device_name
  volume_id   = each.value.id
  instance_id = aws_instance.protected[0].id
}

resource "aws_ebs_volume" "unprotected" {
  for_each = var.prevent_destroy ? toset(keys({})) : toset(keys(local.m))

  availability_zone = data.aws_subnet.selected.availability_zone
  final_snapshot    = try(coalesce(local.m[each.value].final_snapshot), true)
  type              = try(coalesce(local.m[each.value].volume_type), var.ebs_default_settings.volume_type)
  kms_key_id        = try(coalesce(local.m[each.value].kms_key_id), var.ebs_default_settings.kms_key_id)
  size              = try(coalesce(local.m[each.value].volume_size), var.ebs_default_settings.volume_size)
  iops              = try(coalesce(local.m[each.value].iops), var.ebs_default_settings.iops)
  throughput        = try(coalesce(local.m[each.value].throughput), var.ebs_default_settings.throughput) == "0" ? null : try(coalesce(local.m[each.value].throughput), var.ebs_default_settings.throughput)
  encrypted         = true
  snapshot_id       = try(coalesce(local.m[each.value].snapshot_id), null)

  depends_on = [aws_instance.unprotected]
  tags = merge(
    { 
      "Name" = format("%s%s-%s",
      local.region_abbreviation[var.region],
      local.account_abbreviation[data.aws_caller_identity.current.account_id],
      var.ec2_name) 
    },
    var.tags,
    try(var.device_tag_mapping[each.key], tomap({ "drive" = "unknown" })),
    try(local.m[each.value].tags, {})
  )
}

resource "aws_volume_attachment" "unprotected" {
  for_each = aws_ebs_volume.unprotected

  device_name = each.key
  volume_id   = each.value.id
  instance_id = aws_instance.unprotected[0].id

}