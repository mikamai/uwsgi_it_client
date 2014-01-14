require 'spec_helper'

class UwsgiItClient
  describe Getter do
    it 'requires url and auth data' do
      expect { Getter.new }.to raise_error ArgumentError
    end
  end
end