require "uwsgi_it_client/version"

class UwsgiItClient
  attr_reader :username, :password, :domain

  def initialize(opts)
    @domain   = opts.fetch :domain
    @username = opts.fetch :username
    @password = opts.fetch :password
  end
end
