module Namespaceable
  extend ActiveSupport::Concern

  included do
    def self.table_name
      name.split("::").last.underscore.pluralize
    end

    # creates an association for a model in the same namespace
    def self.namespaced_association(assoc_type, assoc_name, options)
      assoc_class = assoc_name.to_s.classify
      opts = { class_name: "#{module_prefix}::#{assoc_class}" }.merge(options)
      if assoc_type == :belongs_to
        associated_table_name = module_prefix.include?("::") ? "#{module_prefix.split('::').last.underscore}_#{assoc_name}" : assoc_name
        opts[:foreign_key] ||= "#{associated_table_name}_id"
      elsif %i[has_one has_many].include? assoc_type
        opts[:foreign_key] ||= "#{table_name.singularize}_id"
      end
      send(assoc_type, assoc_name, **opts)
    end

    def self.module_prefix
      name.deconstantize
    end
  end
end
