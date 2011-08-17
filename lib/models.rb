require "rubygems"
require "sequel"

PROTOCOL, DB_TYPE, DB_NAME, DB_HOST = DB_LOCATION.split(":")

case DB_TYPE
when "Mysql"
  DB = Sequel.mysql(:host => DB_HOST, :user => DB_USER, :password => DB_PASSWORD, :database => DB_NAME)
when "SQLite"
  DB = Sequel.sqlite(DB_NAME)
else
  raise "Invalid DB_LOCATION specified in config/environment.rb"
end

# This plugin gives you the "add_association_dependency" method, which lets you specify other objects to be
# destroyed when the current model gets destroyed, e.g. when you delete a provider, also delete its movies.
Sequel::Model.plugin :association_dependencies

# Auto-populate "created_at" and "updated_at" fields.
Sequel::Model.plugin :timestamps

require "models/user"
require "models/saved_search"
require "models/search_filter"
require "models/commit"
require "models/commit_file"
require "models/comment"
