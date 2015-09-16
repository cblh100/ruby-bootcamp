require 'spec_helper'

describe Linguine do

  let(:linguine_class) { Class.new { include Linguine } }
  let(:linguine_object) { linguine_class.new }

  describe '::page' do

    it 'empty mappings hash' do
      expect(linguine_class.mappings).to be_empty
    end

    it 'store and call block' do
      linguine_class.page '/' do
        'Dummy Output'
      end
      expect(linguine_class.mappings).to include('/')
      expect(linguine_class.mappings['/'].call).to eq('Dummy Output')
    end

  end

  describe '#split_path' do

    it 'hash with only the path' do
      expect(linguine_object.split_path('/about')).to eq( ['/about', nil] )
    end

    it 'hash with path and the language' do
      expect(linguine_object.split_path('/about.de')).to eq(%w(/about de))
    end

    it 'hash with path and the extended language' do
      expect(linguine_object.split_path('/about.en-gb')).to eq(%w(/about en-gb))
    end

  end

  describe '#cache' do
    it 'the cache starts empty' do
      expect(linguine_object.cache).to be_empty
    end
  end

  describe '#add_to_cache' do
    it 'one translation can be added to the cache' do
      linguine_object.add_to_cache( 'hello world', 'de', 'hallo welt' )
      expect(linguine_object.cache).to eq({ 'hello world' => { 'de' => 'hallo welt' } })
    end

    it 'two translations for the same text can be added to the cache' do
      linguine_object.add_to_cache( 'hello world', 'de', 'hallo welt' )
      linguine_object.add_to_cache( 'hello world', 'fr', 'bonjour le monde' )
      expect(linguine_object.cache).to eq({ 'hello world' => { 'de' => 'hallo welt', 'fr' => 'bonjour le monde' } })
    end

    it 'two translations for different text can be added to the cache' do
      linguine_object.add_to_cache( 'hello world 1', 'de', 'hallo welt 1' )
      linguine_object.add_to_cache( 'hello world 2', 'fr', 'bonjour le monde 2' )
      expect(linguine_object.cache).to eq({ 'hello world 1' => { 'de' => 'hallo welt 1' }, 'hello world 2' => {  'fr' => 'bonjour le monde 2' } })
    end
  end

  describe '#translate' do
    context 'translation is already in the cache' do
      let(:text_to_translate) { 'hello world' }
      let(:translated_text) { 'hallo welt (from the cache)' }
      let(:language) { 'de' }

      it 'the cached value is returned' do
        linguine_object.add_to_cache(text_to_translate, language, translated_text)
        allow(linguine_object).to receive(:translator)
        expect(linguine_object).not_to have_received(:translator)
        expect(linguine_object.translate(text_to_translate, language)). to eq(translated_text)
      end
    end

    context 'translation text is already in the cache but not for this language' do
      let(:text_to_translate) { 'hello world' }
      let(:translated_text) { 'bonjour le monde' }

      it 'the translated value is returned' do
        translator = double()
        allow(translator).to receive(:translate).and_return(translated_text)
        linguine_object.add_to_cache(text_to_translate, 'de', 'hallo welt')
        allow(linguine_object).to receive(:translator).and_return(translator)
        expect(linguine_object.translate(text_to_translate, 'fr')). to eq(translated_text)
      end
    end

    context 'translation text is not in the cache' do
      let(:text_to_translate) { 'hello world' }
      let(:translated_text) { 'bonjour le monde' }
      let(:language) { 'fr' }

      it 'the translated value is returned' do
        translator = double()
        allow(translator).to receive(:translate).and_return(translated_text)
        allow(linguine_object).to receive(:translator).and_return(translator)
        expect(linguine_object.translate(text_to_translate, language)). to eq(translated_text)
        expect(linguine_object.cache).to eq({ text_to_translate => { language => translated_text } })
      end
    end

  end

  describe '#call' do



  end

end

