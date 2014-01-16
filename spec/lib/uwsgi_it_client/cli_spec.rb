require 'spec_helper'

describe UwsgiItClient::CLI do
  include CLIHelpers

  subject { UwsgiItClient::CLI }

  context 'me' do
    it 'requires username' do
      expect { exec :me }.to raise_error Thor::RequiredArgumentMissingError, /--username/
    end

    it 'requires password' do
      expect { exec :me }.to raise_error Thor::RequiredArgumentMissingError, /--password/
    end

    it 'requires api url' do
      expect { exec :me }.to raise_error Thor::RequiredArgumentMissingError, /--api/
    end

    it 'is executed if all required arguments are present' do
      expect {
        exec :me, ['-u=asd', '--password=asd', '-a=http://test.dev/api']
      }.to_not raise_error
    end

    context 'when all arguments are filled' do
      before { expect_any_instance_of(UwsgiItClient).to receive(:me).and_return expected }

      subject { exec :me, ['-u=asd', '--password=asd', '-a=http://test.dev/api'] }

      context 'and the server responds with an error' do
        let(:expected) { double response: double(code: '404', message: 'Not found') }

        it 'the error is printed' do
          expect(subject).to match /Cannot retrieve.*404.*Not\sfound/m
        end
      end

      context 'and the server responds correctly' do
        let(:expected) { double response: double(code: '200'), parsed_response: {foo: 'bar'} }

        it 'the result is printed' do
          expect(subject).to match /foo.*bar/m
        end
      end
    end
  end
end