require 'spec_helper'

describe UwsgiItClient::CLI do
  include CLIHelpers

  subject { UwsgiItClient::CLI }

  shared_examples 'requires authentication' do |action_name|
    let(:params) { ['-u=asd', '--password=asd', '-a=http://test.dev/api'] }

    context 'when username is missing' do
      before { params.delete '-u=asd' }
      it 'requires username' do
        expect { exec action_name, params }.to raise_error /--username/
      end
    end

    context 'when password is missing' do
      before { params.delete '--password=asd' }
      it 'requires password' do
        expect { exec action_name, params }.to raise_error /--password/
      end
    end

    context 'when api url is misssing' do
      before { params.delete '-a=http://test.dev/api' }
      it 'requires api url' do
        expect { exec action_name, params }.to raise_error /--api/
      end
    end

    it 'is executed if all required arguments are present' do
      expect { exec action_name, params }.to_not raise_error
    end
  end

  shared_examples 'invokes api action' do |action_name, api_action_name = action_name, default_value = nil|
    subject { exec action_name, [default_value, '-u=asd', '--password=asd', '-a=http://test.dev/api'].compact }

    context 'and the server responds with an error' do
      before do
        fault = double response: double(code: '404', message: 'Not found')
        expect_any_instance_of(UwsgiItClient).to receive(api_action_name).and_return fault
      end

      it 'the error is printed' do
        expect(subject).to match /Cannot execute.*404.*Not\sfound/m
      end
    end

    context 'and the server responds correctly' do
      before do
        expected = double response: double(code: '200'), parsed_response: response
        expect_any_instance_of(UwsgiItClient).to receive(api_action_name).and_return expected
      end

      it 'the result is printed' do
        expect(subject).to match match_regexp
      end
    end
  end

  context 'me' do
    it_behaves_like 'requires authentication', :me

    it_behaves_like 'invokes api action', :me do
      let(:response) do
        { company: 'asd', uuid: 'a-b-c-d' }
      end
      let(:match_regexp) { /company.*uuid/m }
    end
  end

  context 'containers' do
    it_behaves_like 'requires authentication', :containers

    context 'when no id is provided' do
      it_behaves_like 'invokes api action', :containers do
        let(:response) do
          [{ uid: 1234, ip: '10.0.0.2' }]
        end
        let(:match_regexp) { /\[.*\{.*uid.*ip.*\}.*\]/m }
      end
    end

    context 'when an id is provided' do
      it_behaves_like 'invokes api action', :containers, :container, '1' do
        let(:response) do
          { uid: 1234, ip: '10.0.0.2' }
        end
        let(:match_regexp) { /.*\{.*uid.*ip.*\}/m }
      end
    end
  end

  context 'distros' do
    it_behaves_like 'requires authentication', :distros

    it_behaves_like 'invokes api action', :distros do
      let(:response) do
        [{ id: 1, name: 'Sample Linux Distro' }]
      end
      let(:match_regexp) { /\[.*\{.*id.*name.*\}.*\]/m }
    end
  end

  context 'domains' do
    it_behaves_like 'requires authentication', :domains

    it_behaves_like 'invokes api action', :domains do
      let(:response) do
        [{ id: 1, name: 'foobar.com' }]
      end
      let(:match_regexp) { /\[.*\{.*id.*name.*\}.*\]/m }
    end
  end

  describe '#settings' do
    subject { UwsgiItClient::CLI.new }

    let(:current_dir_settings) { double }
    let(:home_settings)        { double }

    context 'when no settings file is present' do
      it 'returns an error hash' do
        expect(subject.settings).to eq UwsgiItClient::ErrorHash.new
      end
    end

    context 'when home dir settings are present' do
      before { subject.stub home_settings: home_settings }

      it 'loads home settings' do
        expect(subject.settings).to eq home_settings
      end
    end

    context 'when current dir settings are present' do
      before { subject.stub current_dir_settings: current_dir_settings }

      it 'loads current dir settings' do
        expect(subject.settings).to eq current_dir_settings
      end

      context 'when home dir settings are present too' do
        before { subject.stub home_settings: home_settings }

        it 'still loads current dir settings' do
          expect(subject.settings).to eq current_dir_settings
        end
      end
    end
  end
end