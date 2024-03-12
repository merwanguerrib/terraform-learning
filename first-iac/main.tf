terraform {
  backend "local" {
    path = "mystate.tfstate"
  }
}

resource "local_file" "this" {
  content  = var.file_content
  filename = "${path.module}/test.txt"
}

module "spells" {
  source = "./modules/spells"

  level_eldritch = 4
  level_fire = 5
  level_frost = 2
}