require "uwsgi_it_client/version"

class UwsgiItClient
  attr_reader :username, :password, :domain

  def initialize(username, password, domain)
    @username, @password, @domain = username, password, domain
  end
end
