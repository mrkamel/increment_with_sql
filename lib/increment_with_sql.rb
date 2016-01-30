
require "increment_with_sql/version"
require "active_record"

module IncrementWithSql
  class NotPersistedError < StandardError; end
  class InvalidAttributeError < StandardError; end

  def increment_with_sql!(attribute, by = 1)
    raise(NotPersistedError, "Record not persisted") if new_record?
    raise(InvalidAttributeError, "Invalid attribute #{attribute}") unless attribute_names.include?(attribute.to_s)

    self.class.transaction do
      self.class.where(:id => id).update_all("#{self.class.connection.quote_column_name attribute} = CASE WHEN #{self.class.connection.quote_column_name attribute} IS NULL THEN 0 ELSE #{self.class.connection.quote_column_name attribute} END + #{by.to_i}")

      send "#{attribute}=", self.class.unscope.where(:id => id).select(attribute).first.send(attribute)

      if respond_to?(:clear_attribute_changes, true)
        send :clear_attribute_changes, attribute
      else
        changed_attributes.except! attribute.to_s
      end
    end 

    self
  end 

  def decrement_with_sql!(attribute, by = 1)
    increment_with_sql! attribute, by * -1
  end 
end

ActiveRecord::Base.send :include, IncrementWithSql

