#require 'rubygems' unless defined?(Gem)
# require 'mongo'
# include Mongo

require 'json'


namespace :import do
  task :hello => :environment do 
    puts Product.count
  end

  task :json => :environment do
    config ||= YAML.load_file(Rails.root.join("config/mongoid.yml")).symbolize_keys
    #config_env = @@config[env.to_sym]
    # host = config[Rails.env.to_sym]["sessions"]["default"]["hosts"][0].split(':')[0]
    # database = config[Rails.env.to_sym]["sessions"]["default"]["database"]

    file = File.read(Rails.root.join('data/102-01-01-109.json'))

    data = JSON.parse(file)

    puts data


  end
end
