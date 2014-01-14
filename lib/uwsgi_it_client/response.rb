class UwsgiItClient
  class Response
    include HTTParty
    format :json

    attr_reader :data

    def initialize(url, auth_data)
      @data = get url, basic_auth: auth_data
    end

    private

    def get(*args)
      self.class.get *args
    end

    def post(*args)
      self.class.get *args
    end
  end
end