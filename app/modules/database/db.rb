# frozen_string_literal: true

module Database
  class DB < ::Configuration
    # Carefull here, we are executing raw query against db, need to santize all inputs

    # GraphQL API structure will be:
    # - userList
    # - getUser
    # - createUser
    # - updateUser
    # - destroyUser
    # where table = 'user'

    # TODO: add support for import and export to and from csv/excel

    def initialize
      # TODO: get configuration and establish connection
      @database = ActiveRecord::Base.establish_connection(
        adapter:  "postgresql",
        host:     "localhost",
        database: "articles",
        username: "",
        password: ""
      )
    end

    def list(table, filters, orders, _page, page_size)
      # TODO:  check if table exist in our db
      @query = "SELECT * FROM #{table}"

      parse_filters(filters)
      parse_orders(orders)

      @query += " LIMIT #{page_size}" if page_size.positive?

      # TODO: implement pagination

      @query += ";"
      @database.exec(query)
    end

    def get(table, id)
      @query = "SELECT * FROM #{table} WHERE id = #{id}"
      @database.exec(query)
    end

    def create(table, values)
      # TODO: implement create
    end

    def update(table, id, values)
      # TODO: implement update
    end

    def destroy(table, id)
      @query = "DELETE FROM #{table} WHERE id = #{id}"
      @database.exec(@query)
    end

    private

    def operations_map
      {
        contains:              "LIKE",
        not_contains:          "NOT LIKE",
        equals:                "=",
        not_equals:            "!=",
        is_null:               "IS NULL",
        is_not_null:           "NOT IS NULL",
        starts_with:           "LIKE",
        ends_with:             "LIKE",
        in:                    "IN",
        not_in:                "NOT IN",
        between:               "BETWEEN",
        not_between:           "NOT BETWEEN",
        greater_than:          ">",
        greater_than_or_equal: ">=",
        less_than:             "<",
        less_than_or_equal:    "<="
      }
    end

    def order_direction_map
      {
        asc:  "ASC",
        desc: "DESC"
      }
    end

    # rubocop:disable Metrics/MethodLength
    def parse_filters(_filter)
      # TODO:  check for subsequent 'and' and 'or' filter
      filter_query = ""
      filter_query += filters.map.with_index do |f, _idx|
        col_name, value_obj = f.entries.first
        operation, value = value_obj.entries.first
        # TODO:  check for each operation and its value
        parsed_value = case operation.to_s
                       when "contains", "not_contains"
                         "'%#{value}%'"
                       when "starts_with"
                         "'%#{value}'"
                       when "ends_with"
                         "'#{value}%'"
                       when "between", "not_between"
                         "#{value.first} AND #{value.last}"
                       when "in", "not_in"
                         "(#{values.join(', ')})"
                       else
                         value
                       end

        "#{col_name} #{operations_map[operation]} #{parsed_value}"
      end.join(" AND ")

      @query += " WHERE #{filter_query}" unless filters.count.positive?
    end
    # rubocop:enable Metrics/MethodLength

    def parse_order(orders)
      order_query = ""
      order_query += orders.map.with_index do |o, _idx|
        col_name, direction = o.entries.first

        "#{col_name} #{direction}"
      end.join(",")

      @query += " ORDER BY #{order_query}" unless orders.count.positive?
    end
  end
end
