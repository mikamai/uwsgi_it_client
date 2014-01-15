require 'uwsgi_it_client/version'
require 'httparty'
require 'active_support/core_ext/module/delegation'

class UwsgiItClient
  API = {
    me:         'me/',
    containers: 'me/containers/',
    container:  'containers',
    distros:    'distros/',
    domains:    'domains/',
  }

  attr_reader :username, :password, :url


  def initialize(opts)
    @url      = opts.fetch :url
    @username = opts.fetch :username
    @password = opts.fetch :password
  end


  API.each do |api_name, path|
    api_url ="#{api_name}_url"

    define_method api_url do |id=nil|
      File.join [url, path, id].compact
    end

    define_method api_name do |id=nil|
      Getter.new send(api_url, id), auth_data
    end
  end


  def post(api_name, payload, opts={})
    Poster.new send("#{api_name}_url", opts[:id]), payload, auth_data
  end

  private

  def auth_data
    {username: username, password: password}
  end
end

require_relative 'uwsgi_it_client/getter'
require_relative 'uwsgi_it_client/poster'