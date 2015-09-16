class Page

  attr_reader :env

  def initialize(env)
    @env = env
  end

  def content_type
    'text/html'
  end

  def body
    ''
  end

end