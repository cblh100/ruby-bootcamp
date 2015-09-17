require 'spec_helper'

describe GoogleTranslator do

  subject(:translator) { described_class.new() }

  describe '#translate' do
    context 'the from and to languages are the same' do
      it "doesn't translate the text" do
        expect(subject.translate('hello world','en','en')).to eq('hello world')
      end
    end

    context 'the from and to languages are different same' do

      let(:text_to_translate) { 'hello world' }
      let(:translated_text) { 'hallo welt' }
      let(:language_from) { 'en' }
      let(:language_to) { 'de' }

      it 'translate the text' do

        mock_google_translate = double()
        allow(mock_google_translate).to receive(:translate).and_return(nil)

        mock_result_parser = double()
        allow(mock_result_parser).to receive(:translation).and_return(translated_text)

        allow(GoogleTranslate).to receive(:new).and_return(mock_google_translate)
        allow(ResultParser).to receive(:new).and_return(mock_result_parser)

        expect(subject.translate(text_to_translate, language_from, language_to)).to eq(translated_text)
      end
    end

  end
end