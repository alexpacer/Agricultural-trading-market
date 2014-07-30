namespace :tester do
  task :tt => :environment do
    ENV['MONGOHQ_URL'] = 'http://heroku:6krWCMaE2KlXSqo8d4Uvn8kx66tgNX9p4W-zq156WNQahqRW11XD0oaCMAFzmhkom74nooMst25Opuczi3eHnw@kahana.mongohq.com:10004/'
    if ENV['MONGOHQ_URL']
      uri = URI.parse('mongodb://heroku:6krWCMaE2KlXSqo8d4Uvn8kx66tgNX9p4W-zq156WNQahqRW11XD0oaCMAFzmhkom74nooMst25Opuczi3eHnw@kahana.mongohq.com:10004/app27912674')
      puts uri.path.sub("/",'')
      puts uri.user
      puts uri.password
      puts uri.host 
      puts uri.port
    end
  end
end