class MsTranslator

  def initialize(oauth)
    @oauth = oauth
  end

  def token
    @oauth.token
  end

  def translate(text, language_from, language_to)
    return text if language_from == language_to
    text.upcase
  end

end