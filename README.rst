# SCS Zuul Installation

## Introduction

This repository contains the infrastructure code you
need to recreate the zuul installation used by SCS to test
testbed deployments.

## Terraform

The current version uses terraform to deploy the basic
infrastructure on wavestack. After all information are
in place apply the manifest to create the basic
infrastructure we want to use for zuul.

<code>terraform apply -var-file config.tfvars</code>

## Ansible

After cloning this repository you will firstly need to add two files:

1. The `.vault-password` containing the password required to use the values contained within the ansible vault.
2. Either a `clouds.yaml`or a `clouds-dev.yaml`, the latter being used for the dev environment only. An example of this file is show in the repository.

NOTE: Running the ansible playbook without specifying any paramatera will cause it to deploy both the productiona and development systems.
For this reason we recommend that you specify the platform to install to.

Example:

`ansible-playbook -i inventory.ini -D zuul.yaml --limit "localhost,zuul-logs-dev.scs.community" --user ubuntu``

The localhost is required because the playbook will create certificates locally before uplaoding them to the platform.