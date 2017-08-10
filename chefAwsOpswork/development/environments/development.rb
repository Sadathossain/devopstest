{
  "name": "development",
  "description": "The master development branch",
  "cookbook_versions": {},
  "json_class": "Chef::Environment",
  "chef_type": "environment",
  "default_attributes": {},
  "override_attributes":
  {
    "environment":"development",
    "nodejs":{
      "name":"Hello_world",
      "repo":"git@github.com:Sadathossain/helloworld_localdev_vagrant.git",
      "revision":"HEAD"
    }
  }
}
