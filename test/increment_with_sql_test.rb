
require File.expand_path("../test_helper", __FILE__)

class IncrementWithSqlTest < IncrementWithSql::TestCase
  def test_increment_with_sql!
    assert_equal 1, Product.create.increment_with_sql!(:version).version
    assert_equal 4, Product.create(:version => 2).increment_with_sql!(:version, 2).version
  end

  def test_decrement_with_sql!
    assert_equal -1, Product.create.decrement_with_sql!(:version).version
    assert_equal 2, Product.create(:version => 4).decrement_with_sql!(:version, 2).version
  end

  def test_indifferent_access
    assert_equal 3, Product.create(:version => 2).increment_with_sql!(:version).version
    assert_equal 3, Product.create(:version => 2).increment_with_sql!("version").version
  end

  def test_changes
    assert Product.create(:version => 2).increment_with_sql!(:version).changes.blank?
    refute Product.create(:version => 2).increment_with_sql!(:version).version_changed?

    product = Product.create(:version => 2).increment_with_sql!(:version)
    Product.update_all :version => 0
    product.save!

    assert_equal 0, Product.find(product.id).version
  end
end

