require 'uwsgi_it_client'
require 'thor'
require 'ap'
require 'active_support/core_ext/hash/keys'

class UwsgiItClient
  class CLI < Thor
    no_commands do
      def print object
        if object.is_a? String
          puts object
        else
          ap object, indent: -2
        end
      end
    end

    desc :me, "Retrieves user profile info"
    method_option :username,  aliases: '-u', type: :string, required: true,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: true,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: true,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def me
      client = UwsgiItClient.new  username: options[:username],
                                  password: options[:password],
                                  url:      options[:api]
      result = client.me
      if result.response.code.to_i != 200
        print "Cannot retrieve user profile info because the server responded with:"
        print status: result.response.code.to_i, description: result.response.message
      else
        print result.parsed_response.symbolize_keys
      end
    end

    desc :containers, "Retrieves containers list"
    method_option :username,  aliases: '-u', type: :string, required: true,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: true,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: true,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def containers
      client = UwsgiItClient.new  username: options[:username],
                                  password: options[:password],
                                  url:      options[:api]
      result = client.containers
      if result.response.code.to_i != 200
        print "Cannot retrieve containers list because the server responded with:"
        print status: result.response.code.to_i, description: result.response.message
      else
        print result.parsed_response.map(&:symbolize_keys)
      end
    end

    desc :distros, "Retrieves distributions list"
    method_option :username,  aliases: '-u', type: :string, required: true,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: true,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: true,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def distros
      client = UwsgiItClient.new  username: options[:username],
                                  password: options[:password],
                                  url:      options[:api]
      result = client.distros
      if result.response.code.to_i != 200
        print "Cannot retrieve distributions list because the server responded with:"
        print status: result.response.code.to_i, description: result.response.message
      else
        print result.parsed_response.map(&:symbolize_keys)
      end
    end

    desc :domains, "Retrieves paired domains list"
    method_option :username,  aliases: '-u', type: :string, required: true,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: true,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: true,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def domains
      client = UwsgiItClient.new  username: options[:username],
                                  password: options[:password],
                                  url:      options[:api]
      result = client.domains
      if result.response.code.to_i != 200
        print "Cannot retrieve paired domains list because the server responded with:"
        print status: result.response.code.to_i, description: result.response.message
      else
        print result.parsed_response.map(&:symbolize_keys)
      end
    end
  end
end