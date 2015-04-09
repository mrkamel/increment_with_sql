
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

ActiveRecord::Base.connection.execute "DROP TABLE IF EXISTS items"

ActiveRecord::Base.connection.create_table :items do |t|
  t.integer :automatic_version
  t.integer :manual_version
  t.string :content
end

class Item < ActiveRecord::Base
  after_save { increment_with_sql! :automatic_version }
end

class IncrementWithSql::TestCase
  def teardown
    Item.delete_all
  end 
end

