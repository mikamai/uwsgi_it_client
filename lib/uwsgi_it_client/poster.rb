class UwsgiItClient
  class Poster
    include HTTParty

    attr_reader :result

    def initialize(url, body, auth_data)
      @result = post url, body: body.to_json, basic_auth: auth_data
    end

    private

    def post(*args)
      self.class.post *args
    end
  end
end