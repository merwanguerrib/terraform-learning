resource "local_file" "frost_spell" {
  content  = "This is a spell book to be use at level ${var.level_frost}"
  filename = "${path.module}/frost-spell.txt"
}

resource "local_file" "fire_spell" {
  content  = "This is a spell book to be use at level ${var.level_fire}"
  filename = "${path.module}/fire-spell.txt"
}

resource "local_file" "eldritch_spell" {
  content  = "This is a spell book that can be used at level ${var.level_eldritch}"
  filename = "${path.module}/eldritch-spell.txt"
}