require 'ap'
require 'thor'
require 'yaml'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/try'
require 'active_support/hash_with_indifferent_access'

require 'uwsgi_it_client'

class UwsgiItClient
  class CLI < Thor
    no_commands do
      def login_params
        {
          username: options[:username] || settings[:username],
          password: options[:password] || settings[:password],
          url:      options[:api]      || settings[:api]
        }
      end

      def settings
        current_dir_settings or home_settings or ErrorHash.new
      end

      def home_settings
        load_settings File.expand_path('~/.uwsgi_it_client.yml')
      end

      def current_dir_settings
        load_settings File.join Dir.pwd, '.uwsgi_it_client.yml'
      end

      def load_settings(file)
        if File.file? file
          hash = YAML.load_file file
          ActiveSupport::HashWithIndifferentAccess.new hash
        end
      end

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
    method_option :username,  aliases: '-u', type: :string, required: false,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: false,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: false,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def me
      client = UwsgiItClient.new login_params
      manage_action_result client.me
    end

    desc 'containers [ID]', "Retrieves containers list (if no ID is provided) or show container info"
    method_option :username,  aliases: '-u', type: :string, required: false,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: false,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: false,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def containers id = nil
      client = UwsgiItClient.new login_params
      result = id && client.container(id) || client.containers
      manage_action_result result
    end

    desc :distros, "Retrieves distributions list"
    method_option :username,  aliases: '-u', type: :string, required: false,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: false,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: false,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def distros
      client = UwsgiItClient.new login_params
      manage_action_result client.distros
    end

    desc :domains, "Retrieves paired domains list"
    method_option :username,  aliases: '-u', type: :string, required: false,
                              desc: 'uwsgi.it username', banner: 'kratos'
    method_option :password,  aliases: '-p', type: :string, required: false,
                              desc: 'uwsgi.it password', banner: 'deimos'
    method_option :api,       aliases: '-a', type: :string, required: false,
                              desc: 'uwsgi.it api base url', banner: 'https://foobar.com/api'
    def domains
      client = UwsgiItClient.new login_params
      manage_action_result client.domains
    end
  end
end