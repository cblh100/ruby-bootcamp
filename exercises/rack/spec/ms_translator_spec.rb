require 'spec_helper'

describe MsTranslator do

  let(:dummy_token) { 'dummy_token' }
  let(:oauth) do
    dbl = double()
    allow(dbl).to receive(:token).and_return(dummy_token)
    dbl
  end
  subject(:translator) { described_class.new(oauth) }

  describe '#token' do
    it 'gets an oauth token' do
      expect(subject.token).to eq(dummy_token)
    end
  end

  describe '#translate' do
    context 'the from and to languages are the same' do
      it "doesn't tranlate the text" do
        expect(subject.translate('hello world','en','en')).to eq('hello world')
      end
    end

    context 'the from and to languages are different same' do

      let(:translate_uri) { 'http://api.microsofttranslator.com/v2/Http.svc/Translate' }

      it 'translate the text' do
        stub_request(:get, translate_uri).to_return(:body => 'hallo welt')

        expect(subject.translate('hello world','en','de')).to eq('hallo welt')
        expect(WebMock).to have_requested(:post, translate_uri).
            with( :headers => {'Authorisation' => "Bearer #{dummy_token}"}, :query => {:text => 'hello world', :from => 'en', :to  => 'de'})
      end
    end

  end

end