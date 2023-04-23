##################################################################################
## Virtual Machine
##################################################################################

output "id" {
  description = "The ID of the virtual machine."
  value       = try(opentelekomcloud_compute_instance_v2.otc_af_base_compute.id, "")
}

output "image_name" {
  description = "The image name used for the system disk."
  value       = try(opentelekomcloud_compute_instance_v2.otc_af_base_compute.image_name, "")
}

output "flavor_name" {
  description = "The flavor name used for the virtual machine."
  value       = try(opentelekomcloud_compute_instance_v2.otc_af_base_compute.flavor_name, "")
}

output "availability_zone" {
  description = "The availability zone the virtual machine is deployed in."
  value       = try(opentelekomcloud_compute_instance_v2.otc_af_base_compute.availability_zone, "")
}


##################################################################################
## Network
##################################################################################

output "public_ip" {
  description = "If used together with EIP, this returns the actual elastic IP assigned to the virtual machine."
  value       = length(opentelekomcloud_vpc_eip_v1.otc_af_base_compute_public_ip) > 0 ? try( opentelekomcloud_vpc_eip_v1.otc_af_base_compute_public_ip[0].publicip[0].ip_address, "") : null
}

output "access_ip_v4" {
  description = "The first detected Fixed IPv4 address or the Floating IP."
  value       = try( opentelekomcloud_compute_instance_v2.otc_af_base_compute.access_ip_v4, "")
}

output "access_ip_v6" {
  description = "The first detected Fixed IPv6 address."
  value       = try( opentelekomcloud_compute_instance_v2.otc_af_base_compute.access_ip_v6, "")
}

output "networks" {
  description = "List of all networks attached to this virtual machine."
  value       = try(opentelekomcloud_compute_instance_v2.otc_af_base_compute.network, "" )
}


##################################################################################
## Security
##################################################################################

output "security_groups" {
  description = "The list of security group assigned to the virtual machine."
  # value       = try(opentelekomcloud_networking_secgroup_v2.otc_af_base_compute_securitygroup.name, "")
  value         = try(opentelekomcloud_compute_instance_v2.otc_af_base_compute.security_groups, "")
}