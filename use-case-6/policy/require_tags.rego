package main

deny[msg] {
  not input.config.tags["Name"]
  msg = sprintf("Resource %v must have a Name tag", [input.name])
}
