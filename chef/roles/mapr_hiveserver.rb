name "mapr_hive"
description "MapR Hive Role"
run_list(
  "role[mapr_base]",
  "recipe[mapr::hive]",
  "recipe[mapr::hiveserver2]",
  "recipe[mapr::hivemetastore]"
)
default_attributes(

)
