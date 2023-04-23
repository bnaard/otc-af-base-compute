locals {
  aksk_csv_file_content = csvdecode(file(var.aksk_file))
  ak                    = local.aksk_csv_file_content[0]["Access Key Id"]
  sk                    = local.aksk_csv_file_content[0]["Secret Access Key"]
}

# Configure the OpenTelekomCloud Provider
provider "opentelekomcloud" {
  access_key  = local.ak
  secret_key  = local.sk
  domain_name = var.domain_name
  tenant_name = var.tenant_name
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
}

module "otc_af_base_compute_test_01_basic_creation" {
    count                     = 1
    source                    = "github.com/bnaard/otc-af-base-compute" # ref=

    name                      = "bastion"  
    tags                      = merge( var.tags, { function = "bastion"} )
    subnet_id                 = opentelekomcloud_vpc_subnet_v1.dmz_subnet.id
    # fixed_ip_v4               = var.bastion_fixed_ip_v4
    allow_tcp_forwarding      = true
    create_public_ip          = true
    eip_bandwidth             = 5
    system_disk_size          = 7
    system_disk_type          = "SATA"
    availability_zone         = var.bastion_availability_zone
    flavor_name               = var.bastion_flavor_name
    image_name                = var.bastion_image_name
    ssh_port                  = var.bastion_ssh_port
    trusted_ssh_origins       = var.bastion_trusted_ssh_origins
    cloud_init_config         = join("\n", [for filepath in local.cloud_init_files : file(filepath)])
    emergency_user            = var.emergency_user
    emergency_user_spec       = var.emergency_user_spec
}