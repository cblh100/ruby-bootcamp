require 'spec_helper'

describe OAuth do

  let(:client_id) { 'test_client_id' }
  let(:client_secret) { 'test_client_secret' }
  subject(:oauth) { described_class.new( client_id, client_secret ) }

  describe 'new' do
    it 'initialises correctly' do
      expect(subject.client_id).to eq(client_id)
      expect(subject.client_secret).to eq(client_secret)
    end
  end

  describe 'token' do
    let(:dummy_token) { 'dummy_token' }
    context "the token hasn't expired" do
      it 'the current token is used' do
        subject.instance_variable_set(:@access_token, dummy_token)
        allow(subject).to receive(:expires_at).and_return(Time.now + 1)
        expect(subject).not_to receive(:get_new_token)
        expect(subject.token).to eq(dummy_token)
      end
    end

    context 'the token has expired' do
      it 'a new token is requested' do
        subject.instance_variable_set(:@access_token, nil)
        allow(subject).to receive(:expires_at).and_return(Time.now - 1)
        expect(subject).to receive(:get_new_token).and_return(dummy_token)
        expect(subject.token).to eq(dummy_token)
      end
    end

  end

  describe 'get_new_token' do

    require 'json'

    let(:access_token) { 'test_access_token' }
    let(:oauth_uri) { 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13' }
    let(:expires_in) { 600 }

    let(:dummy_response) do
      JSON.generate( {
        :token_type => 'http://schemas.xmlsoap.org/ws/2009/11/swt-token-profile-1.0',
        :access_token => access_token,
        :expires_in => expires_in.to_s,
        :scope => 'test_scope'
      } )
    end

    it 'requests a new token from the oauth server' do
      stub_request(:post, oauth_uri).to_return(:body => dummy_response)

      Timecop.freeze do
        expect(subject.get_new_token).to eq(access_token)
        expect(subject.expires_at).to eq(Time.now + expires_in)
        expect(subject.token).to eq(access_token)
      end

      expect(WebMock).to have_requested(:post, oauth_uri).
          with(:body => "client_id=test_client_id&client_secret=test_client_secret&grant_type=client_credentials&scope=http%3A%2F%2Fapi.microsofttranslator.com%2F")

    end

  end

end
