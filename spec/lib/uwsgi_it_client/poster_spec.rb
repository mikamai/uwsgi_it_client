require 'spec_helper'

class UwsgiItClient
  describe Poster do
    it 'requires url, body and auth data' do
      expect { Poster.new }.to raise_error ArgumentError
    end
  end
end