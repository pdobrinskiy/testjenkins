terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
    }
  }
}

#configure provider with your cisco aci credentials.
provider "aci" {
  # cisco-aci user name
  username = "admin"
  # cisco-aci password
  password = "!v3G@!4@Y"
  # cisco-aci url
  url = "https://sandboxapicdc.cisco.com"
  #url = "https://10.122.189.179"
  #  url      = "https://10.122.189.163"
  insecure = true
}


resource "aci_tenant" "CX" {
  name = "CXchanged"
}

resource "aci_vrf" "CX" {
  tenant_dn = aci_tenant.CX.id
  name      = "CX"
}


resource "aci_vlan_pool" "CX_vlan_pool" {
  name        = "CX_vlan_pool"
  description = "CX_vlan_pool"
  alloc_mode  = "static"
}

resource "aci_ranges" "vlan_pool_static" {
  vlan_pool_dn = aci_vlan_pool.CX_vlan_pool.id
  from         = "vlan-100"
  to           = "vlan-500"
  alloc_mode   = "inherit"
  role         = "external"
}


resource "aci_physical_domain" "CX_physdom" {
  name                      = "CX_physdom"
  relation_infra_rs_vlan_ns = aci_vlan_pool.CX_vlan_pool.id
}




resource "aci_attachable_access_entity_profile" "CX_aaep" {
  name                    = "CX_aaep"
  relation_infra_rs_dom_p = [aci_physical_domain.CX_physdom.id]
}
