require 'spec_helper'

describe UwsgiItClient do
  let(:username) { double }
  let(:password) { double }
  let(:url)      { double }

  subject { UwsgiItClient.new username: username, password: password, url: url }

  context 'when the option param is missing' do
    it { expect { UwsgiItClient.new }.to raise_error ArgumentError }
  end

  context 'when a required option is missing' do
    it 'raises an error' do
      expect { UwsgiItClient.new username: username }.to raise_error
    end
  end

  context 'when passing valid options' do
    it 'sets username, password, domain attributes as expected' do
      subject.url.should      == url
      subject.password.should == password
      subject.username.should == username
    end

    it 'sets the auth_data hash' do
      subject.auth_data.should == { username: subject.username, password: subject.password}
    end
  end

  context 'when accessing me API' do
    it 'sets correctly the url' do
      subject.me_url.should == "#{subject.url}/me"
    end

    it 'delegates to the response' do
      UwsgiItClient::Response.should_receive(:new)
      subject.me
    end
  end
end