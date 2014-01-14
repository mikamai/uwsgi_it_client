require 'uwsgi_it_client/version'
require 'httparty'

class UwsgiItClient
  attr_reader :username, :password, :url

  def initialize(opts)
    @url      = opts.fetch :url
    @username = opts.fetch :username
    @password = opts.fetch :password
  end

  def me
    Response.new(me_url, auth_data)
  end

  def me_url
    File.join url, 'me'
  end

  def containers
    Response.new(containers_url, auth_data)
  end

  def containers_url
    File.join url, 'me/containers'
  end

  def auth_data
    {username: username, password: password}
  end
end

require_relative 'uwsgi_it_client/response'