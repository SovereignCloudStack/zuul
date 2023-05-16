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

If you want to install zuul on a given infrastructure you need to provide some information.
Please check that your file tree looks like this if you want to create a basic installation.

<pre>
[0][user@host:ansible]$ tree
.
├── certs
├── clouds.yaml
├── elements
│   ├── infra-package-needs
│   │   ├── element-deps
│   │   ├── install.d
│   │   │   ├── 10-packages
│   │   │   ├── 40-install-bindep
│   │   │   └── 89-rsyslog
│   │   ├── package-installs.yaml
│   │   ├── pkg-map
│   │   ├── post-install.d
│   │   │   ├── 80-enable-haveged
│   │   │   ├── 80-enable-infra-services
│   │   │   └── 89-sshd
│   │   ├── pre-install.d
│   │   │   └── 00-gentoo-useflags
│   │   ├── README.rst
│   │   └── rsyslog.d
│   │       └── 50-default.conf
│   └── zuul-worker
│       ├── element-deps
│       ├── extra-data.d
│       │   └── 60-zuul-user
│       ├── install.d
│       │   └── 60-zuul-worker
│       └── README.rst
├── inventory.ini
├── nodepool
├── nodepool.pub
├── package-installs.yaml
├── pem-files
│   └── my-zuul-app-private-key.pem
├── server.crt
├── zuul-config.yaml
└── zuul.yaml

11 directories, 28 files
</pre>
