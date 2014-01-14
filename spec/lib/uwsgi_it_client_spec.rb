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
      expect(subject.url).to      eq url
      expect(subject.password).to eq password
      expect(subject.username).to eq username
    end

    it 'sets the auth_data hash' do
      expect(subject.auth_data).to eq username: subject.username, password: subject.password
    end
  end

  context 'when accessing me API' do
    it 'sets correctly the url' do
      expect(subject.me_url).to eq "#{subject.url}/me"
    end

    it 'delegates to the response' do
      expect(UwsgiItClient::Response).to receive :new
      subject.me
    end
  end
end