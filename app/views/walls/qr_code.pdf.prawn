#<h2>Discuss this shit online:</h2>
#<h1><%= @wall.title %></h1>
#<img src=" %>" />

require "open-uri"

prawn_document() do |pdf|
  pdf.text "Hello World"
  qr_url = 'http://chart.apis.google.com/chart?cht=qr&chs=300x300&choe=UTF-8&chld=H%7C0&chl=' + CGI::escape(show_by_code_url(@wall.code))
  pdf.image open(qr_url)
end
