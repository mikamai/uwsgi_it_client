require 'spec_helper'

class UwsgiItClient
  describe Getter do
    let(:url) { 'http://somedomain.com/path' }
    let(:auth_data) { {username: 'racco', password: 'party'} }

    subject { Getter.new url, auth_data }

    it 'requires url and auth data' do
      expect { Getter.new }.to raise_error ArgumentError
    end

    %w[success? body headers response].each do |method_name|
      it "delegates #{method_name} to result object" do
        result = double
        subject.stub(result: result)
        result.should_receive method_name
        subject.send method_name
      end
    end
  end
end