# DEBUG
variable "on_testing" {
  # set `false` if you want to setup production deployment
  default = true
}

# META
variable "company" {
  # THIS LINE IS REPLACE by `create-ssh-key.sh`
  default = "github" # company
}

variable "project" {
  # THIS LINE IS REPLACE by `create-ssh-key.sh`
  default = "1ambda" # project
}

variable "environment" {
  default = "DEV"
}

variable "region" {
  default = "ap-northeast-2"
}
variable "availability_zones" {
  type = "list"
  default = [
    "ap-northeast-2a",
    "ap-northeast-2c",
  ]
}

# Domain, SSL (AWS ACM)
locals {
  domain_name = "${lower(var.project)}.${lower(var.company)}.io"
  local_acm_validation_method = "EMAIL" # or `DNS`
  external_acm_use = false # set true if you want to use an ACM already existing
  external_acm_arn = "arn" # set external ACM arn if you want to use an ACM already existing
}

# Domain (ACM)
locals {
  kops_cluster_name = "kops.${lower(var.project)}.${lower(var.company)}.k8s.local"
}

# Access Control: SSH
locals {
  ssh_public_key_path = "~/.ssh/key.${lower(var.project)}.${lower(var.company)}.io_rsa.pub"
  ssh_private_key_path = "~/.ssh/key.${lower(var.project)}.${lower(var.company)}.io_rsa"
  bastion_ssh_port = 22
}

# Access Control (Whitelist)
locals {
  whitelist_enabled = "false"
  whitelist_targets = [
    "18.18.18.18/32",
  ]
}

# Slack Alert Channels

locals {
  slack_alert_enable = true
  slack_webhook_url_alert = "hooks.slack.com/services/"
  slack_webhook_channel_alert = "#infra-alert"
}
