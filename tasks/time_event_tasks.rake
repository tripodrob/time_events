# desc "Explaining what the task does"
# task :time_event do
#   # Task goes here
# end
namespace :db do
  namespace :migrate do
    description = "Migrate the database through scripts in vendor/plugins/time_event/lib/db/migrate"
    description << "and update db/schema.rb by invoking db:schema:dump."  
    description << "Target specific version with VERSION=x. Turn off output with VERBOSE=false."  

    desc description 
    task :time_event => :environment do  
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true"  : true
      ActiveRecord::Migrator.migrate("vendor/plugins/time_event/lib/db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end  
  end 
end 