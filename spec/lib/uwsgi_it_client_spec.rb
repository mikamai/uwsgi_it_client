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
  end

  { me: 'me', containers: 'me/containers', distros: 'distros', domains: 'domains' }.each do |api_name, url|
    context "when accessing #{api_name} API" do
      it 'sets correctly the url' do
        expect(subject.send "#{api_name}_url").to eq "#{subject.url}/#{url}/"
      end

      it 'creates a new getter object' do
        expect(UwsgiItClient::Getter).to receive :new
        subject.send api_name
      end

      it 'returns the getter object' do
        UwsgiItClient::Getter.stub get: {}
        expect(subject.send api_name).to be_a UwsgiItClient::Getter
      end
    end
  end

  context 'when adding an id to the url' do
    context 'when the id is present' do
      it 'converts the id to string if necessary' do
        subject.container_url(3001).should eq "#{subject.url}/containers/3001"
      end
    end

    context 'when id is nil' do
      it 'removes the id param entirely' do
        subject.container_url(nil).should eq "#{subject.url}/containers"
      end
    end
  end

  context 'when POSTing to API' do
    let(:payload)   { {some: :payload} }
    let(:api_name)  { :domains }
    let(:auth_data) { subject.send :auth_data }

    it 'creates a Poster instance' do
      UwsgiItClient::Poster.should_receive :new
      subject.post api_name, payload, auth_data
    end
  end

  context 'when DELETEing to API' do
    it 'creates a Deleter instance' do
    end
  end

  describe '#container_url' do
    it 'returns the expected url' do
      expect(subject.container_url('3001')).to eq "#{url}/containers/3001"
    end
  end
end