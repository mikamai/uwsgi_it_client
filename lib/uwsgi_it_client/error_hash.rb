class UwsgiItClient
  class ErrorHash < Hash
    def initialize
      super do |hash, option|
        hash[option] = raise "No value provided for required options '--#{option}'"
      end
    end
  end
end