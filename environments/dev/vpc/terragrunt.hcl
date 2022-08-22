# Most module instantiations will only need to have this block
include "root" {
  path = find_in_parent_folders("root.hcl")
}

## To get some output as to what is in local.root:
#include "root" {
#  path = find_in_parent_folders("root.hcl")
#  expose = true
#}
#locals {
#  root =  include.root.locals
#}
#inputs = {
#  other = {
#    root = local.root
#  }
#}
