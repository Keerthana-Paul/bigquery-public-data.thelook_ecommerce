view: order_items {
  derived_table: {
    sql: SELECT * FROM `bigquery-public-data.thelook_ecommerce.order_items`
      ;;
  }

  measure: count {
    label: "Order count"
    type: count
    drill_fields: [order_id,product_id,products.name,user_id,users.user_name, users.age, users.city, users.country,created_at_date]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [time, hour, date, week, month, year, hour_of_day, day_of_week, month_num, raw, week_of_year,month_name]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: shipped_at {
    type: time
    sql: ${TABLE}.shipped_at ;;
  }

  dimension_group: delivered_at {
    type: time
    sql: ${TABLE}.delivered_at ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  set: detail {
    fields: [
      id,
      order_id,
      user_id,
      product_id,
      inventory_item_id,
      status,
      created_at_time,
      shipped_at_time,
      delivered_at_time,
      returned_at_time,
      sale_price
    ]
  }

# new fields
  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [order_id,product_id,products.name,user_id,users.user_name, users.age, users.city, users.country,created_at_date]
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  dimension: days_since_order {
  #  label: "Recency"
    sql: TIMESTAMP_DIFF(${created_at_raw},CURRENT_TIMESTAMP(), DAY) ;;
  }


}
