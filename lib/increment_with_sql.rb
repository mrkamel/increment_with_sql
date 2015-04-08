
require "increment_with_sql/version"
require "active_record"

module IncrementWithSql
  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)

    original_value_sql = "CASE WHEN `#{attribute}` IS NULL THEN 0 ELSE `#{attribute}` END"

    self.class.transaction do
      self.class.where(:id => id).update_all("`#{attribute}` = #{original_value_sql} + #{by.to_i}")

      send "#{attribute}=", self.class.where(:id => id).select(attribute).first.send(attribute)

      if respond_to?(:clear_attribute_changes, true)
        send :clear_attribute_changes, [attribute, attribute.to_sym, attribute.to_s]
      else
        changed_attributes.except! attribute, attribute.to_sym, attribute.to_s
      end
    end 

    self
  end 

  def decrement_with_sql!(attribute, by = 1)
    increment_with_sql! attribute, by * -1
  end 
end

ActiveRecord::Base.send :include, IncrementWithSql

