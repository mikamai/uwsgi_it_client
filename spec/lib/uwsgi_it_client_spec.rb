require 'spec_helper'

describe UwsgiItClient do
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:url)      { 'https://domain.com/path/to/api' }

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
      expect(subject.url).to      eq url
      expect(subject.password).to eq password
      expect(subject.username).to eq username
    end

    it 'sets the auth_data hash' do
      expect(subject.auth_data).to eq username: subject.username, password: subject.password
    end
  end

  { me: 'me', containers: 'me/containers' }.each do |api_name, url|
    context "when accessing #{api_name} API" do
      it 'sets correctly the url' do
        expect(subject.send "#{api_name}_url").to eq "#{subject.url}/#{url}"
      end

      it 'creates a new response object' do
        expect(UwsgiItClient::Response).to receive :new
        subject.send api_name
      end

      it 'returns the response object' do
        UwsgiItClient::Response.stub get: {}
        expect(subject.send api_name).to be_a UwsgiItClient::Response
      end

      it 'memoizes the response' do
        pending
        expect(UwsgiItClient::Response).to receive :new
        2.times { subject.send api_name }
      end
    end
  end
end