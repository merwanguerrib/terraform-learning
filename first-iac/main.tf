terraform {
  required_version = ">= 0.12"

  backend "local" {
    path = "mystate.tfstate"
  }

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.50"
    }
  }
}
resource "local_file" "this" {
  content  = "Hello, Payfit !"
  filename = "${path.module}/test.txt"
}

resource "local_file" "config_files" {
  for_each = toset(var.names)

  filename = "${path.module}/config-${each.key}.txt"
  content  = "This is a generic message for ${each.key}"
}


resource "local_file" "log_files" {
  count = var.log_count

  filename = "${path.module}/log-${count.index + 1}.txt"
  content  = "This is log message number ${count.index + 1}"
}

module "spells" {
  source = "./modules/spells"

  level_eldritch = 4
  level_fire     = 5
  level_frost    = 2
}