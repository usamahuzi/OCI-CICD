# OCI CI/CD Guide - Implementation Repository

This repository contains the code and resources referenced in my guide on implementing CI/CD pipelines within Oracle Cloud Infrastructure.

https://highoncloud.co.uk/oci-cicd-automation/

**Purpose:**

This repository serves as a practical companion to the guide, providing you with:

* **Terraform Code:** Infrastructure as Code (IaC) to provision the necessary OCI resources for your CI/CD pipeline.
* **Code Repository Examples:** Sample code and configurations demonstrating how to integrate your application code into the pipeline, specifically focusing on deploying OCI Functions.

**Guide Overview:**

The accompanying guide walks you through the steps involved in setting up a robust CI/CD pipeline on OCI, covering topics such as:

* Deploying a complete CI/CD automation stack on OCI through terraform
* Configuring OCI Build Pipelines.
* Using OCI DevOps to deploy OCI Functions.

**Getting Started:**

1.  **Read the Guide:** Begin by thoroughly reviewing the associated guide to understand the concepts and steps involved.
2.  **Clone the Repository:** Clone this repository to your local machine:

    ```bash
    git clone https://github.com/usamahuzi/OCI-CICD.git
    ```

3.  **Terraform Deployment of OCI DevOps:**
    * Navigate to the `terraform` directory: `cd OCI-CICD/terraform`
    * Ensure you have Terraform installed and configured with your OCI credentials.
    * Initialize Terraform: `terraform init`
    * Review and modify the `variables.tf` file to customize your environment.
    * Plan the infrastructure: `terraform plan`
    * Apply the changes: `terraform apply`

4.  **Code Repository Exploration:**
    * Explore the `code-repository-contents` directory to understand the structure of the example application.
    * Follow the guide's instructions to integrate your own application code.


**Prerequisites:**

* An Oracle Cloud Infrastructure tenancy.
* Terraform installed and connected to your tenancy. 
* Understanding of OCI DevOps, Functions, and Terraform.

**Contributing:**

Contributions to this repository are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

**Author:**

Usamah Ali Hussain
