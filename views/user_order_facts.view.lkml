view: user_order_facts {
    derived_table: {
      sql: SELECT
        user_id
        ,COUNT (DISTINCT(order_id)) AS lifetime_orders
        ,MIN(created_at) AS first_order
        , CAST(MAX(created_at)  AS TIMESTAMP)  AS latest_order
      FROM bigquery-public-data.thelook_ecommerce.order_items
      GROUP BY user_id
       ;;
    }

    dimension: user_id {
      type: number
      sql: ${TABLE}.user_id ;;
    }

    dimension: lifetime_orders {
      type: number
      sql: ${TABLE}.lifetime_orders ;;
    }

    dimension_group: first_order {
      type: time
      sql: ${TABLE}.first_order ;;
    }

    dimension_group: latest_order {
      type: time
      sql: ${TABLE}.latest_order ;;
    }

  dimension: days_as_customer {
    description: "Days between first and latest order"
    type: number
    sql: TIMESTAMP_DIFF(${TABLE}.latest_order, ${TABLE}.first_order, DAY)+1 ;;
  }

  dimension: repeat_customer {
    description: "Lifetime Count of Orders > 1"
    type: yesno
    sql: ${lifetime_orders} > 1 ;;
  }

  dimension: days_since_order {
    #  label: "Recency"
    sql: TIMESTAMP_DIFF(${TABLE}.created_at,CURRENT_TIMESTAMP(), DAY) ;;
  }

    }
