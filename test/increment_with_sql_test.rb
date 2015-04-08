
require File.expand_path("../test_helper", __FILE__)

class IncrementWithSqlTest < IncrementWithSql::TestCase
  def test_increment_with_sql!
    assert_equal 1, Product.create.increment_with_sql!(:version).version
    assert_equal 4, Product.create(:version => 2).increment_with_sql!(:version, 2).version

    assert Product.create(:version => 2).increment_with_sql!(:version).changes.blank?
    refute Product.create(:version => 2).increment_with_sql!(:version).version_changed?
  end

  def test_decrement_with_sql!
    assert_equal -1, Product.create.decrement_with_sql!(:version).version
    assert_equal 2, Product.create(:version => 4).decrement_with_sql!(:version, 2).version

    assert Product.create(:version => 2).decrement_with_sql!(:version).changes.blank?
    refute Product.create(:version => 2).decrement_with_sql!(:version).version_changed?
  end
end

