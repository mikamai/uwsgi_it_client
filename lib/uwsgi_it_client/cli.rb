require 'thor'
require 'ap'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/try'

require 'uwsgi_it_client'

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

      def manage_action_result result
        if result.response.code.to_i != 200
          print "Cannot execute the desired action. The server responded with:"
          print status: result.response.code.to_i, description: result.response.message
        else
          response = result.parsed_response.try(:symbolize_keys) || result.parsed_response.map(&:symbolize_keys)
          if block_given?
            yield response
          else
            print response
          end
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
      manage_action_result client.me
    end

    desc 'containers [ID]', "Retrieves containers list (if no ID is provided) or show container info"
    method_option :username,  aliases: '-u', type: :string, required: true,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: true,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: true,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def containers id = nil
      client = UwsgiItClient.new  username: options[:username],
                                  password: options[:password],
                                  url:      options[:api]
      result = id && client.container(id) || client.containers
      manage_action_result result
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
      manage_action_result client.distros
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
      manage_action_result client.domains
    end
  end
end