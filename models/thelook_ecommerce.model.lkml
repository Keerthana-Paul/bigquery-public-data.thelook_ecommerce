connection: "looker_demo"

# include all the views
include: "/views/**/*.view"

datagroup: thelook_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: thelook_ecommerce_default_datagroup

explore: order_items
{
  join: orders {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.order_id} = ${order_items.order_id} ;;
  }

  join: users {
  type: left_outer
  relationship: many_to_one
  sql_on: ${users.id} = ${order_items.user_id} ;;
}

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.id} = ${order_items.product_id} ;;
  }

  join: events {
    type: left_outer
    relationship: many_to_one
    sql_on: ${events.user_id} = ${order_items.user_id} ;;
  }

  join: inventory_items {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }
}

explore: distribution_centers {}

explore : events {
  label : "Events and Users"

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${users.id} = ${events.user_id} ;;
  }
}
