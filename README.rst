# SCS Zuul Installation

## Introduction

This repository contains the infrastructure code necessary to recreate the Zuul installation used by SCS for testing testbed deployments.

## Terraform

The current version uses Terraform to deploy the basic infrastructure on Wavestack. Follow these steps to deploy the infrastructure:

1. Ensure all required information is configured in the `config.tfvars` file.
2. Apply the Terraform manifest to create the basic infrastructure:

  terraform apply -var-file config.tfvars


## Ansible

After cloning this repository, follow these steps to set up Ansible:

1. Add the following file:
   - `ansible/.vault-password`: Contains the password required to use values stored in the Ansible vault.

2. Run the Ansible playbook from the `ansible` directory. Specify the platform to install to using the `--limit` option:

Example for dev deployment:

  ansible-playbook -i inventory.ini -D zuul.yaml --limit "localhost,zuul-logs-dev.scs.community" --user ubuntu

Note: The `localhost` is required because the playbook creates certificates locally before uploading them to the platform.
