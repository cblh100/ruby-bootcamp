require 'google_translate'
require 'google_translate/result_parser'

class GoogleTranslator

  def translate(text, language_from, language_to)
    return text if language_from == language_to

    result = translator.translate(language_from, language_to, text)
    result_parser = ResultParser.new result
    result_parser.translation
  end

  private

  def translator
    @google_translator ||= GoogleTranslate.new
  end


end