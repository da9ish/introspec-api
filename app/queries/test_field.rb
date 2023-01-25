# frozen_string_literal: true

class TestField < Introspec::BaseQuery
  type String, null: false

  def resolve
    "Hello World!"
  end
end
