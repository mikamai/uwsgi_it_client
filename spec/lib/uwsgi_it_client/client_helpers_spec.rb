require 'spec_helper'


class UwsgiItClient
  describe ClientHelpers do
    context 'when extending a UwsgiItClient instance' do
      let(:username) { 'username' }
      let(:password) { 'password' }
      let(:url)      { 'https://domain.com/path/to/api' }

      subject do
        client = UwsgiItClient.new(
          username: username,
          password: password,
          url: url
        )
        client.extend(ClientHelpers)
        client
      end

      %w[company= password= set_distro add_keys add_key add_domain delete_domain].each do |method_name|
        it "responds to #{method_name}" do
          expect(subject).to respond_to method_name
        end
      end
    end
  end
end
