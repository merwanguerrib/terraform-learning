terraform {
  backend "local" {
    path = "mystate.tfstate"
  }
}

resource "local_file" "this" {
  content  = var.file_content
  filename = "${path.module}/test.txt"
}
