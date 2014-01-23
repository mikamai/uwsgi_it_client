require 'spec_helper'

class UwsgiItClient
  describe ErrorHash do
    it 'raises an error everytime for every key' do
      expect( -> {subject[:key]}).to raise_error
    end
  end
end