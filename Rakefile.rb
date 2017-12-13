task :create_db do
  ruby "crawler_create.rb"
end

task :populate_db do
  ruby "crawler_populate.rb"
end

task :clean do
  system "rm crawler.db"
end
