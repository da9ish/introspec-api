# frozen_string_literal: true

class PolymorphicAssociationLoader < GraphQL::Batch::Loader
  attr_reader :model, :association_name

  def initialize(model, association_name)
    @model = model
    @association_name = association_name
  end

  def load(object)
    super(object)
  end

  def perform(objects)
    result = query(objects)
    objects.each { |object| fulfill(object, result.select { |record| record.identifier == object.identifier }) }
  end

  private

  def query(objects)
    model.where(association_name: objects.map(&:id))
  end
end
