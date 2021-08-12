output "vm_name01" {
  value = vsphere_virtual_machine.linux_vm.*.name  
}

output "vm_ip01" {
  value =  vsphere_virtual_machine.linux_vm.*.default_ip_address
}

