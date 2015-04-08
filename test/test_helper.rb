
require "increment_with_sql"

begin
  require "minitest"

  class IncrementWithSql::TestCase < MiniTest::Test; end 
rescue LoadError
  require "minitest/unit"

  class IncrementWithSql::TestCase < MiniTest::Unit::TestCase; end 
end

require "minitest/autorun"
require "active_record"
require "yaml"

DATABASE = ENV["DATABASE"] || "sqlite"

ActiveRecord::Base.establish_connection YAML.load_file(File.expand_path("../database.yml", __FILE__))[DATABASE]

ActiveRecord::Base.connection.execute "DROP TABLE IF EXISTS products"

ActiveRecord::Base.connection.create_table :products do |t|
  t.integer :version
end

class Product < ActiveRecord::Base
end

class IncrementWithSql::TestCase
  def teardown
    Product.delete_all
  end 
end

