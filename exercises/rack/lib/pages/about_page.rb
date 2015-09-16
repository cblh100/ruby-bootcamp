require_relative 'page'

class AboutPage < Page

  def content_type
    'text/plain'
  end

  def body
    'Something about this site!!!'
  end

end