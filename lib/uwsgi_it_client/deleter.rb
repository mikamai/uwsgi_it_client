class UwsgiItClient
  class Deleter
    include HTTParty

    attr_reader :result

    def initialize(url, body, auth_data)
      @result = delete url, body: body.to_json, basic_auth: auth_data
    end

    private

    def delete(*args)
      self.class.delete *args
    end
  end
end