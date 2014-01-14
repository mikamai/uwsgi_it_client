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
      File.join url, path, '/'
    end

    define_method api_name do
      Getter.new send(api_url), auth_data
    end
  end

  def container_url(c_id)
    File.join url, 'containers', c_id
  end


  def company=(value)
    Poster.new me_url, {company: value}, auth_data
  end

  def password=(password)
    Poster.new me_url, {password: password}, auth_data
  end

  private

  def auth_data
    {username: username, password: password}
  end
end

require_relative 'uwsgi_it_client/getter'
require_relative 'uwsgi_it_client/poster'