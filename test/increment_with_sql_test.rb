
require File.expand_path("../test_helper", __FILE__)

class IncrementWithSqlTest < IncrementWithSql::TestCase
  def test_new_record
    assert_raises IncrementWithSql::NotPersistedError do
      Item.new.increment_with_sql! :manual_version
    end
  end

  def test_invalid_attribute
    assert_raises IncrementWithSql::InvalidAttributeError do
      Item.create!.increment_with_sql! :unknown_version
    end
  end

  def test_increment_with_sql!
    assert_equal 1, Item.create!.increment_with_sql!(:manual_version).manual_version
    assert_equal 4, Item.create!(:manual_version => 2).increment_with_sql!(:manual_version, 2).manual_version
  end

  def test_decrement_with_sql!
    assert_equal -1, Item.create!.decrement_with_sql!(:manual_version).manual_version
    assert_equal 2, Item.create!(:manual_version => 4).decrement_with_sql!(:manual_version, 2).manual_version
  end

  def test_indifferent_access
    assert_equal 2, Item.create!(:manual_version => 1).increment_with_sql!(:manual_version).manual_version
    assert_equal 2, Item.create!(:manual_version => 1).increment_with_sql!("manual_version").manual_version
  end

  def test_manual_changes
    assert Item.create!(:manual_version => 1).increment_with_sql!(:manual_version).changes.blank?
    refute Item.create!(:manual_version => 1).increment_with_sql!(:manual_version).manual_version_changed?

    item = Item.create!(:manual_version => 2).increment_with_sql!(:manual_version)
    Item.update_all :manual_version => 0
    item.save!

    assert_equal 0, Item.find(item.id).manual_version
  end

  def test_automatic_changes
    item = Item.create!
    item.update_attributes! :content => "Content"

    assert_equal 2, item.automatic_version
    assert item.changes.blank?
    refute item.content_changed?
    refute item.automatic_version_changed?
  end

  def test_mixed_changes
    item = Item.create!(:manual_version => 1)
    item.content = "Content"
    item.increment_with_sql! :manual_version

    assert_equal 2, item.manual_version

    refute item.changes.blank?
    refute item.manual_version_changed?
    assert item.content_changed?
  end
end

