require 'uwsgi_it_client/version'

class UwsgiItClient
  attr_reader :username, :password, :url

  def initialize(opts)
    @url      = opts.fetch :url
    @username = opts.fetch :username
    @password = opts.fetch :password
  end

  def auth_data
    {username: username, password: password}
  end
end
