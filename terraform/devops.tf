resource "oci_ons_notification_topic" "devops_notification_topic" {
    compartment_id = var.compartment_id
    name = var.topic_name
}

resource "oci_devops_project" "devops_project" {
    compartment_id = var.compartment_id
    name = var.project_name
    notification_config {
        topic_id = oci_ons_notification_topic.devops_notification_topic.id
    }
}

resource "oci_devops_repository" "code_repository" {
    name = var.repo_name
    repository_type = "HOSTED"
    project_id = oci_devops_project.devops_project.id
}

resource "oci_devops_trigger" "push_trigger" {
    display_name = var.trigger_name
    project_id = oci_devops_project.devops_project.id
    trigger_source = "DEVOPS_CODE_REPOSITORY"
    repository_id = oci_devops_repository.code_repository.id
    actions {
        build_pipeline_id = oci_devops_build_pipeline.devops_build_pipeline.id
        type = "TRIGGER_BUILD_PIPELINE"
    }
}

data "oci_objectstorage_namespace" "current" {
    compartment_id = var.tenancy_ocid
}

resource "oci_devops_build_pipeline" "devops_build_pipeline" {
    project_id = oci_devops_project.devops_project.id
    display_name = var.build_pipeline_name
    build_pipeline_parameters {
        items {
            default_value = var.username
            name          = "USERNAME"
        }
        items {
            default_value = var.image_tag
            name          = "IMAGE_TAG"            
        }
        items {
            default_value = var.image_name
            name          = "IMAGE_NAME"
        }
        items {
            default_value = data.oci_objectstorage_namespace.current.namespace
            name          = "NAMESPACE"
        }
        items {
            default_value = var.registry_domain
            name          = "DOCKER_REGISTRY"
        }        
    }
}

resource "oci_devops_build_pipeline_stage" "build_managed_deployment_stage" {
    build_pipeline_id = oci_devops_build_pipeline.devops_build_pipeline.id
    build_pipeline_stage_type = "BUILD"
    display_name = "create-container-image"
    build_spec_file = "build_spec.yaml"
    primary_build_source = oci_devops_repository.code_repository.name
    build_pipeline_stage_predecessor_collection {
        items {
            id = oci_devops_build_pipeline.devops_build_pipeline.id
        }
    }
    build_source_collection {
        items {
            branch = "main"
            connection_type = "DEVOPS_CODE_REPOSITORY"
            repository_id = oci_devops_repository.code_repository.id
            repository_url = oci_devops_repository.code_repository.http_url
        }
    }
}

resource "oci_devops_build_pipeline_stage" "build_trigger_deployment_stage" {
    build_pipeline_id = oci_devops_build_pipeline.devops_build_pipeline.id
    build_pipeline_stage_type = "TRIGGER_DEPLOYMENT_PIPELINE"
    build_pipeline_stage_predecessor_collection {
        items {
            id = oci_devops_build_pipeline_stage.build_managed_deployment_stage.id
        }
    }
    is_pass_all_parameters_enabled = true
    deploy_pipeline_id = oci_devops_deploy_pipeline.devops_deploy_pipeline.id
}

resource "oci_devops_deploy_pipeline" "devops_deploy_pipeline" {
    project_id = oci_devops_project.devops_project.id
    display_name = var.deploy_pipeline_name
}

resource "oci_devops_deploy_stage" "test_deploy_stage" {
    deploy_pipeline_id = oci_devops_deploy_pipeline.devops_deploy_pipeline.id
    deploy_stage_type = "DEPLOY_FUNCTION"
    display_name = "Deploy function"
    docker_image_deploy_artifact_id = oci_devops_deploy_artifact.container_deploy_artifact.id
    function_deploy_environment_id = oci_devops_deploy_environment.target_function_environment.id
    deploy_stage_predecessor_collection {
        items {
            id = oci_devops_deploy_pipeline.devops_deploy_pipeline.id
        }
    }
}

resource "oci_devops_deploy_environment" "target_function_environment" {
    project_id = oci_devops_project.devops_project.id
    deploy_environment_type = "FUNCTION"
    display_name = var.environment_name
    function_id = var.function_id
}

resource "oci_devops_deploy_artifact" "container_deploy_artifact" {
    project_id = oci_devops_project.devops_project.id
    argument_substitution_mode = "NONE"
    deploy_artifact_type = "DOCKER_IMAGE"
    display_name = var.artifact_display_name
    deploy_artifact_source {
        deploy_artifact_source_type = "OCIR"
        image_uri = "${var.registry_domain}/${data.oci_objectstorage_namespace.current.namespace}/${var.image_name}:${var.image_tag}"
    }
}


