data "vsphere_datacenter" "dc" {
  name = var.pro_datacenter
}

resource "vsphere_file" "upload_file" {
  datacenter       = "sunshineit"
  datastore        = "iscsi_lun01"
  source_file      = "/Users/mengyinggang/Downloads/VMware-ESXi-6.7.0.update03-17700523-LNV-20210408.iso"
  destination_file = "iso/VMware-ESXi-6.7.0.update03-17700523-LNV-20210408.iso"
}