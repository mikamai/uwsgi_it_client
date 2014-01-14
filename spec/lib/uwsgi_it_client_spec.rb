require 'spec_helper'

describe UwsgiItClient do
  let(:username)  { double }
  let(:password)  { double }
  let(:domain)    { double }

  subject { UwsgiItClient.new username: username, password: password, domain: domain }

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
      subject.domain.should   == domain
      subject.password.should == password
      subject.username.should == username
    end
  end
end