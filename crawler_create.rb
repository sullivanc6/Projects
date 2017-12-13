#!/usr/bin/ruby
#Connor Sullivan
#crawler_create.rb
#12/6/17

require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crawler.db') 
ActiveRecord::Schema.define do 
  create_table :pages  do  |t|
    t.string  :url,  :null  =>  false
    t.string  :title
    t.string  :content_type
    t.date    :last_modified
    t.string  :status
  end 
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crawler.db') 
ActiveRecord::Schema.define do 
  create_table :links  do  |t|
    t.integer  :from_page_id,  :null  =>  false
    t.integer  :to_page_id,  :null  =>  false
  end 
end

ActiveRecord::Schema.define do
  add_foreign_key :links, :pages, column: :from_page_id, primary_key: :id
end

ActiveRecord::Schema.define do
  add_foreign_key :links, :pages, column: :to_page_id, primary_key: :id
end

ActiveRecord::Schema.define do
  add_index :pages, [:url], :unique => true
end

ActiveRecord::Schema.define do
  add_index :links, [:from_page_id, :to_page_id], :unique => true
end
