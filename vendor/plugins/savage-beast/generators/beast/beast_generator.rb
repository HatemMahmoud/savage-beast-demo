require 'pathname'

# Mostly pinched from http://github.com/ryanb/nifty-generators/tree/master

Rails::Generator::Commands::Base.class_eval do
  def file_contains?(relative_destination, line)
    File.read(destination_path(relative_destination)).include?(line)
  end
end

Rails::Generator::Commands::Create.class_eval do
  def insert_into(file, line)
    logger.insert "#{line} into #{file}"
    unless options[:pretend] || file_contains?(file, line)
      pattern = if file =~ /routes.rb$/ then /Routes.draw\s+do\s*.+$/ else  /^(class|module) .+$/ end
      gsub_file file, pattern do |match|
        "#{match}\n #{line}"
      end
    end
  end
end

Rails::Generator::Commands::Destroy.class_eval do
  def insert_into(file, line)
    logger.remove "#{line} from #{file}"
    unless options[:pretend]
      gsub_file file, "\n #{line}", ''
    end
  end
end

Rails::Generator::Commands::List.class_eval do
  def insert_into(file, line)
    logger.insert "#{line} into #{file}"
  end
end

class BeastGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      m.insert_into "config/routes.rb", <<-'ROUTES'
 # Savage beast routes BEGIN
 map.resources :posts, :name_prefix => 'all_', :collection => { :search => :get }
	map.resources :forums, :topics, :posts, :monitorship

  %w(forum).each do |attr|
    map.resources :posts, :name_prefix => "#{attr}_", :path_prefix => "/#{attr.pluralize}/:#{attr}_id"
  end
  
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
      topic.resource :monitorship, :controller => :monitorships
    end
  end
  # Savage beast routes END

      ROUTES

      m.insert_into 'app/models/user.rb', 'include SavageBeast::UserInit'
      m.insert_into 'app/helpers/application_helper.rb', 'include SavageBeast::ApplicationHelper'
      
      destination_root = "/public/"
      templates_dir = (Pathname(__FILE__).dirname + 'templates').expand_path
      
      %w(stylesheets images javascripts).each { |asset|
        destination_path = destination_root + asset
        assets_dir = templates_dir + 'public' + asset
        
        m.directory destination_path + "/savage_beast"

        Pathname.glob(assets_dir + '**' + '*') do |file|
          destination_file = (assets_dir + 'savage_beast' + file.relative_path_from(assets_dir)).relative_path_from(templates_dir).to_s
          source_file = file.relative_path_from(templates_dir).to_s
          
          if file.directory?
            m.directory destination_file
          else
            m.file source_file, destination_file
          end
        end
      }

      m.migration_template "migrations/create_savage_tables.rb", 'db/migrate', :migration_file_name => "create_savage_tables"
    end
  end
end
