# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

#require 'tasks/rails'

begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "savage-beast"
    gemspec.summary = "Rails forum plugin"
    gemspec.description = "Rails 2.3 compatible version Savage Beast with i18n support"
    gemspec.email = "pavel@valodzka.name"
    gemspec.homepage = "http://github.com/valodzka/savage-beast"
    gemspec.authors = ["Rick Olson", "Josh Goebel", "Bill Harding", "Pavel Valodzka"]
  end
  
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

