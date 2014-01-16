require_relative '../lib/uwsgi_it_client'
require_relative '../lib/uwsgi_it_client/cli'

Dir["#{File.dirname __FILE__}/support/**/*.rb"].each { |f| require f }