resource "azurerm_resource_group" "moodle" {
  name = "moodle-rg"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "moodle" {
  name = "moodle-aks"
  location = "${azurerm_resource_group.moodle.location}"
  resource_group_name = "${azurerm_resource_group.moodle.name}"
  dns_prefix = "moodle"

  linux_profile {
    admin_username = "catadmin"

    ssh_key {
      key_data = "ssh-rsa ..."
    }
  }

  agent_pool_profile {
    name = "default"
    count = 3
    vm_size = "Standard_DS1_v2"
    os_type = "Linux"
    os_disk_size_gb = "30"
  }

  service_principal {
    client_id = "00000000-0000-0000-0000-000000000000"
    client_secret = "000000000000000000000000000000000000"
  }

  tags {
    Environment = "Development"
  }
}

output "id" {
    value = "${azurerm_kubernetes_cluster.moodle.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.moodle.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.moodle.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.moodle.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.moodle.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.moodle.kube_config.0.host}"
}

