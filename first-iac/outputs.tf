output "file_id" {
  value       = local_file.this.id
  description = "This output should return the id of the file"
}

output "complex_output" {
  value = {
    frost_spell    = module.spells.frost_spell
    fire_spell     = module.spells.fire_spell
    eldritch_spell = module.spells.eldritch_spell
  }
}

output "config_files" {
  value = [for file in local_file.config_files : file.filename]
}

output "log_files" {
  value = [for file in local_file.log_files : file.filename]
}