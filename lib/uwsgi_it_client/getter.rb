class UwsgiItClient
  class Getter
    include HTTParty
    format :json

    attr_reader :result

    def initialize(url, auth_data)
      @result = get url, basic_auth: auth_data
    end

    private

    def get(*args)
      self.class.get *args
    end
  end
end
