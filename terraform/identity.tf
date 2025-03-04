resource "oci_identity_dynamic_group" "devops_dynamic_group" {
    compartment_id = var.tenancy_ocid
    description = "DevOps dynamic group"
    matching_rule = "Any {ALL {resource.type = 'devopsdeploypipeline', resource.compartment.id = '${var.compartment_id}'},ALL {resource.type = 'devopsrepository', resource.compartment.id = '${var.compartment_id}'},ALL {resource.type = 'devopsbuildpipeline',resource.compartment.id = '${var.compartment_id}'},ALL {resource.type = 'devopsconnection',resource.compartment.id = '${var.compartment_id}'}}"
    name = var.dynamic_group_name
}

resource "oci_identity_policy" "devops_policy" {
    compartment_id = var.tenancy_ocid
    description = "DevOps policy"
    name = "DevOpsPolicy"
    statements = [
        "Allow dynamic-group ${oci_identity_dynamic_group.DevOps_dynamic_group.name} to manage all-resources in compartment ${var.compartment_id}"
    ]
}