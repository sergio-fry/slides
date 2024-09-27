require "active_support/concern"
require "active_support/core_ext/enumerable"

class EntityChanges
  def initialize(entity)
    @entity = entity
  end

  def previous_values = @previous_values ||= current_values

  def commit = @previous_values = copied(current_values)

  def current_values
    @entity.instance_variables.to_h do |name|
      [pretty_name(name), current(name)]
    end
  end

  delegate :empty?, to: :changes

  def changed?(name) = changes.key?(pretty_name(name))

  def changes
    variables.filter_map do |name|
      current_value = current(name)
      previous_value = previous(name)

      next if current_value.is_a?(EntityChanges)

      changed = if current_value.respond_to?(:changed?)
        current_value.changed? || current_value.object_id != previous_value.object_id
      else
        current_value != previous_value
      end

      next unless changed

      [pretty_name(name), [previous_value, current_value]]
    end.to_h
  end

  def pretty_name(name) = name.to_s.sub("@", "").to_sym

  def current(name) = @entity.instance_variable_get(instance_name(name))

  def instance_name(name) = "@#{pretty_name(name)}"

  def previous(name) = previous_values[pretty_name(name)]

  def variables = (previous_values.keys + current_values.keys).uniq

  def clear_previous = @previous_values = {}

  def previous_nil? = @previous_values == {}

  def copied(values)
    values = values.dup

    values.each do |name, value|
      case value
      when Array
        values[name] = value.dup
      end
    end

    values
  end
end

# Автоматически определяет, какие поля изменились
module Dirty
  extend ActiveSupport::Concern

  included do
    def initialize(**args)
      super
      @changes = EntityChanges.new(self)
      @changes.commit
    end

    def changed?(attr = nil)
      if attr.nil?
        !@changes.changes.empty?
      else
        @changes.changed? attr
      end
    end

    def changes_applied = @changes.commit
    def new? = @changes.previous_nil?
    def changes = @changes.changes
    def previous_value(attr) = @changes.previous(attr)

    def mark_as_new
      @changes.clear_previous

      pubsub.publish :create, { entity: self } if defined?(pubsub)
    end
  end
end
