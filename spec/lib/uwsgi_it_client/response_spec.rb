require 'spec_helper'

class UwsgiItClient
  describe Response do
    it 'requires url and auth data' do
      expect { Response.new }.to raise_error ArgumentError
    end
  end
end