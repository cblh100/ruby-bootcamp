require_relative 'page'

class HomePage < Page

  def body
    text = <<-HTML
      <html>
        <head>
          <title>Home</title>
        </head>
        <body>
          <h1>Home</h1>
          <p>The site of shiny stuff <a href="#">click me!</a>. this is fun!</p>
        </body>
      </html>
    HTML
    text
  end

end