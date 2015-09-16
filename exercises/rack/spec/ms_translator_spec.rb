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
      it "doesn't translate the text" do
        expect(subject.translate('hello world','en','en')).to eq('hello world')
      end
    end

    context 'the from and to languages are different same' do

      let(:translate_uri) { 'http://api.microsofttranslator.com/v2/Http.svc/Translate' }
      let(:text_to_translate) { 'hello world' }
      let(:translated_text) { 'hallo welt' }
      let(:language_from) { 'en' }
      let(:language_to) { 'de' }

      it 'translate the text' do
        stub_request(:get, "#{translate_uri}?from=en&text=hello%20world&to=de").to_return(:body => "<string xmlns=\"http://schemas.microsoft.com/2003/10/Serialization/\">#{translated_text}</string>")

        expect(subject.translate(text_to_translate, language_from, language_to)).to eq(translated_text)
        expect(WebMock).to have_requested(:get, translate_uri).
            with( :headers => {'Authorization' => "Bearer #{dummy_token}"}, :query => {:text => text_to_translate, :from => language_from, :to  => language_to})
      end
    end

  end

end