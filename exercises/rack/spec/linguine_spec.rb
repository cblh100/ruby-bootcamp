require 'spec_helper'

describe Linguine do

  let(:linguine_class) { Class.new { include Linguine } }
  let(:linguine_object) { linguine_class.new }

  describe '::page' do

    it 'empty mappings hash' do
      expect(linguine_class.mappings).to be_empty
    end

    it 'stores a page' do
      page = double()

      linguine_class.page '/', page
      expect(linguine_class.mappings).to include('/')
      expect(linguine_class.mappings['/']).to eq(page)
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

  describe '#translate_html' do

    it 'translates all text nodes in the html' do

      html = <<-HTML.gsub(/^[ ]{8}/, '')
        <html>
          <head>
            <title>Home</title>
          </head>
          <body>
            <h1>header 1</h1>
            <h2>header 2</h2>
            <h3>header 3</h3>
            <h4>header 4</h4>
            <h5>header 5</h5>
            <h6>header 6</h6>
            <p>The site of shiny stuff <a href="#">click me!</a>. this is fun!</p>
          </body>
        </html>
      HTML

      translated_html = <<-HTML.gsub(/^[ ]{8}/, '')
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
        <html>
          <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>text</title>
          </head>
          <body>
            <h1>text</h1>
            <h2>text</h2>
            <h3>text</h3>
            <h4>text</h4>
            <h5>text</h5>
            <h6>text</h6>
            <p>text<a href="#">text</a>text</p>
          </body>
        </html>
      HTML

      allow(linguine_object).to receive(:translate).and_return('text')
      expect(linguine_object.translate_html(html, 'de')).to eq(translated_html)
    end

  end

  describe '#translate' do

    let(:text_to_translate) { 'hello world' }
    let(:translated_text) { 'bonjour le monde' }
    let(:language) { 'fr' }

    let(:translator) do
      translator = double()
      allow(translator).to receive(:translate).and_return(translated_text)
      translator
    end

    context 'translation is already in the cache' do
      it 'the cached value is returned' do
        linguine_object.add_to_cache(text_to_translate, language, translated_text)
        allow(linguine_object).to receive(:translator)
        expect(linguine_object).not_to have_received(:translator)
        expect(linguine_object.translate(text_to_translate, language)). to eq(translated_text)
      end
    end

    context 'translation text is already in the cache but not for this language' do
      it 'the translated value is returned' do
        linguine_object.add_to_cache(text_to_translate, 'de', 'hallo welt')
        allow(linguine_object).to receive(:translator).and_return(translator)
        expect(linguine_object.translate(text_to_translate, 'fr')). to eq(translated_text)
      end
    end

    context 'translation text is not in the cache' do
      it 'the translated value is returned' do
        allow(linguine_object).to receive(:translator).and_return(translator)
        expect(linguine_object.translate(text_to_translate, language)). to eq(translated_text)
        expect(linguine_object.cache).to eq({ text_to_translate => { language => translated_text } })
      end
    end

  end

  describe '#call' do

    let(:env) { {'REQUEST_PATH' => '/mock.de'} }
    let(:translator) do
      translator = double()
      allow(translator).to receive(:translate).and_return('My german mock body')
      translator
    end

    it 'page not found' do
      expect(linguine_object.call(env)).to eq([404, {'Content-Type' => 'text/plain'}, 'Oooops, there is nothing here' ])
    end

    it 'translates a plain text page' do
      class PlainTextPage < Page
        def content_type
          'text/plain'
        end
        def body
          'My mock body'
        end
      end

      allow(linguine_object).to receive(:translator).and_return(translator)

      linguine_class::page('/mock', PlainTextPage )
      expect(linguine_object.call(env)).to eq([200, {'Content-Type' => 'text/plain'}, 'My german mock body' ])
    end

    it 'translates a html page' do
      class HtmlPage < Page
        def content_type
          'text/html'
        end
        def body
          '<html><body><p>My mock body</p></body></html>'
        end
      end

      expected_html = <<-HTML.gsub(/^[ ]{8}/, '')
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd\">
        <html><body><p>My german mock body</p></body></html>
      HTML

      allow(linguine_object).to receive(:translator).and_return(translator)

      linguine_class::page('/mock', HtmlPage )
      expect(linguine_object.call(env)).to eq([200, {'Content-Type' => 'text/html'}, expected_html ])
    end

  end

end

