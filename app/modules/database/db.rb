# frozen_string_literal: true

module Database
  class DB < Configuration
    # GraphQL API structure will be:
    # - userList
    # - getUser
    # - createUser
    # - updateUser
    # - destroyUser
    # where table = 'user'

    def initialize
      # TODO: Add pg gem and get db url from config
      @database = pg.connect(**config)
    end

    def list(table, filter, order, page, page_size)
      # TODO:  check if table exist in our db
      query = "SELECT * FROM #{table}"

      if (filter.count.positive?)
        # TODO:  check for subsequent 'and' and 'or' filter
        filter_query = ""
        filter_query += filter.map.with_index do |f, idx|
          col_name, value_obj = f.entries.first
          operation, value = value_obj.entries.first
          # TODO:  check for each operation and its value
          case operation.to_s
          when 'contains', 'not_contains'
            parsed_value = "'%#{value}%'"
          when 'starts_with'
            parsed_value = "'%#{value}'"
          when 'ends_with'
            parsed_value = "'#{value}%'"
          when 'between', 'not_between'
            parsed_value = "#{value.first} AND #{value.last}"
          when 'in', 'not_in'
            parsed_value = "(#{values.join(', ')})"
          else
            parsed_value = value
          end

          "#{col_name} #{operations_map[operation]} #{parsed_value}"
        end.join(" AND ")

        query += " WHERE #{filter_query}"
      end

      if (order.count.positive?)
        order_query = ""
        order_query += order.map.with_index do |o, idx|
          col_name, direction = o.entries.first

          "#{col_name} #{direction}"
        end.join(",")

        query += " ORDER BY #{order_query}"
      end

      query += " LIMIT #{page_size}" if page_size.positive?

      # TODO: implement pagination

      query += ";"
    end

    def get(table, id)
      "SELECT * FROM #{table} WHERE id = #{id}"
    end

    def create(table, values)
      # TODO: implement create
    end

    def update(table, id, values)
      # TODO: implement update
    end

    def destroy(table, id)
      "DELETE FROM #{table} WHERE id = #{id}"
    end

    private 

    def operations_map
      {
        contains: 'LIKE',
        not_contains: 'NOT LIKE',
        equals: '=',
        not_equals: '!=',
        is_null: 'IS NULL',
        is_not_null: 'NOT IS NULL',
        starts_with: 'LIKE',
        ends_with: 'LIKE',
        in: 'IN',
        not_in: 'NOT IN',
        between: 'BETWEEN',
        not_between: 'NOT BETWEEN',
        greater_than: '>',
        greater_than_or_equal: '>=',
        less_than: '<',
        less_than_or_equal: '<='
      }
    end

    def order_direction_map
      {
        asc: 'ASC',
        desc: 'DESC'
      }
    end
  end
end