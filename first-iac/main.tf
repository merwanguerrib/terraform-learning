terraform {
  backend "local" {
    path = "mystate.tfstate"
  }
}

resource "local_file" "this" {
  content  = "Hello, Payfit !"
  filename = "${path.module}/test.txt"
}