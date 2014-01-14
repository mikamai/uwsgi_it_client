require 'uwsgi_it_client/version'
require 'httparty'

class UwsgiItClient
  API = {
    me: 'me',
    containers: 'me/containers'
  }

  attr_reader :username, :password, :url


  def initialize(opts)
    @url      = opts.fetch :url
    @username = opts.fetch :username
    @password = opts.fetch :password
  end


  API.each do |api_name, path|
    api_url ="#{api_name}_url"

    define_method api_url do
      File.join url, path
    end

    define_method api_name do
      ivar_name = "@#{api_name}"
      instance_variable_get ivar_name or begin
        response = Response.new send(api_url), auth_data
        instance_variable_set ivar_name, response
      end
    end
  end

  private

  def auth_data
    {username: username, password: password}
  end
end

require_relative 'uwsgi_it_client/response'