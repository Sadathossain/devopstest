name "nodejsrole hello world"
description "The base role"
run_list "recipe[git]","recipe[apt]","recipe[ark]","recipe[vagrant-node-simple::deploy]","recipe[vagrant-node-simple::install]","recipe[vagrant-node-simple:start]"
