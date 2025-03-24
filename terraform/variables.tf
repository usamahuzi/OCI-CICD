## API Key Authentication
variable "tenancy_ocid" {
  type          = string
  default       = "ocid1.tenancy.oc1.put-your-tenancy-ocid-here"
}

variable "region" {
  type          = string
  default       = "region-here" # e.g. "uk-london-1"
}
variable "user_ocid" {
  type          = string
  default       = "ocid1.user.oc1.put-your-user-ocid-here"
}

variable "fingerprint" {
  type          = string
  default       = "put-your-user-fingerprint-here"
}

variable "compartment_id" {
    type          = string
    default       = "ocid1.compartment.oc1.put-your-compartment-ocid-here"
}

variable "key_path" {
  type          = string
  default       = "/path/to/your/private/key.pem"
}

## DevOps Project
variable "dynamic_group_name" {
  type          = string
  default       = "put-your-dynamic-group-name-here"
}
variable "policy_name" {
  type          = string
  default       = "put-your-policy-name-here"
}
variable "topic_name" {
  type          = string
  default       = "put-your-topic-name-here"
}
variable "project_name"{
  type          = string
  default       = "put-your-project-name-here"
}

variable "repo_name" {
  type          = string
  default       = "put-your-repo-name-here"
}

variable "trigger_name" {
  type          = string
  default       = "put-your-trigger-name-here"
}

## Build Pipeline
variable "build_pipeline_name" {
  type            = string
  default         = "put-your-build-pipeline-name-here"
}
variable "username" {
  type            = string
  default         = "put-your-oci-username-here"
}
variable "image_tag" {
  type            = string
  default         = "latest"
}
variable "image_name" {
  type            = string
  default         = "put-your-image-name-here"
}
variable "registry_domain" {
  type            = string
  default         = "put-your-registry-domain-here" # e.g. "ocir.uk-london-1.oci.oraclecloud.com"
}

## Deploy Pipeline
variable "deploy_pipeline_name" { 
  type            = string
  default         = "put-your-deploy-pipeline-name-here"
}

## Deploy Environment
variable "environment_name" {
  type            = string
  default         = "put-your-environment-name-here"
}
variable "function_id" {
  type            = string
  default         = "ocid1.fnfunc.put-your-function-ocid-here-or-refer-to-the-terraform-resource"
}

## Deploy Artifact
variable "artifact_display_name" {
  type            = string
  default         = "put-your-artifact-display-name-here"
}