
##################################################################################
## Network
##################################################################################

resource "opentelekomcloud_vpc_eip_v1" "otc_af_base_compute_public_ip" {
  count           = local.create && var.create_public_ip ? 1 : 0
  tags            = var.tags

  publicip {
    type          = "5_bgp"
  }
  bandwidth {
    name          = "bandwidth"
    size          = var.public_ip_bandwidth
    share_type    = var.public_ip_bandwidth_share_type
    charge_mode   = "traffic"
  }
}


# resource "opentelekomcloud_networking_floatingip_associate_v2" "floatingip_associate" {
#   count       = var.create_public_ip ? 1 : 0
#   floating_ip = opentelekomcloud_vpc_eip_v1.public_ip[0].publicip.0.ip_address
#   port_id     = opentelekomcloud_compute_instance_v2.node.network.0.port
# }
