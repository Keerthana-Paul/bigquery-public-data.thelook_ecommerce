connection: "looker_demo"

# include all the views
include: "/views/**/*.view"

datagroup: thelook_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: thelook_ecommerce_default_datagroup

explore: users {}

explore: products {}

explore: orders {}

explore: order_items {}

explore: events {}

explore: inventory_items {}

explore: distribution_centers {}
