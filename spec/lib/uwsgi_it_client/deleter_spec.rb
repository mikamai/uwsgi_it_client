require 'spec_helper'

class UwsgiItClient
  describe Deleter do
    it 'requires url, body and auth data' do
      expect { Deleter.new }.to raise_error ArgumentError
    end
  end
end