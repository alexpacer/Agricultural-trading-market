#require 'rubygems' unless defined?(Gem)
# require 'mongo'
# include Mongo

require 'date'
require 'json'


namespace :import do
  task :hello => :environment do 
    puts Product.count
  end

  task :json => :environment do
    dir = Dir[Rails.root.join('data','transactions','veggies','*.json')]
    tt = DateTime.now
    puts "#{dir.count()} files found to be processed"
    dir.each do |x|
      ENV['FILE'] = x
      Rake::Task["import:single"].execute
    end
    esplated = (DateTime.now.to_time - tt.to_time) / 60
    puts "operation took #{esplated} minutes"
  end

  task :single => :environment do
    file = File.read(Rails.root.join(ENV["FILE"]))
    data = JSON.parse(file)

    ff = /\/(?<yy>[0-9]{3})-(?<mm>[0-9]{2})-(?<dd>[0-9]{2})-(?<market>[0-9]{2,3}).json/.match(ENV["FILE"])
    date = Date.parse("#{ff[:yy].to_i+1911}-#{ff[:mm]}-#{ff[:dd]}")

    # Creates market if not exists
    market = nil
    begin
      market = Market.find_by(:code => ff[:market])
    rescue Mongoid::Errors::DocumentNotFound
      market = Market.create(:code => ff[:market], :name => "N/A")
    end

    puts "importing #{ENV["FILE"]}"

    veg = data
      .collect { |d| 
        prod = d["product"]
        if Product.where(name: prod["name"], type: prod["type"], process: prod["process"]).count == 0
          prod = Product.create(prod)
        else
          prod = Product.find_by(name: prod["name"], type: prod["type"], process: prod["process"])
        end
        
        d.delete "product"
        d.merge({ product_id: prod.id, market_id: market.id, date: date })
        # if Veggie.where(date: date, market_id: market.id, product: prod).count == 0
        #   d.merge({ product: prod, market_id: market.id, date: date })
        # else
        #   nil
        # end
      }

    Veggie.collection.insert(veg)
    puts "#{veg.count} transactions inserted."
  end


  task :not_that_i_am_willing_to_run_this => :environment do
    config ||= YAML.load_file(Rails.root.join("config/mongoid.yml")).symbolize_keys
    #config_env = @@config[env.to_sym]
    # host = config[Rails.env.to_sym]["sessions"]["default"]["hosts"][0].split(':')[0]
    # database = config[Rails.env.to_sym]["sessions"]["default"]["database"]
  end
end
