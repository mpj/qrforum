#<h2>Discuss this shit online:</h2>
#<h1><%= @wall.title %></h1>
#<img src=" %>" />

require "open-uri"


prawn_document(:page_layout => :landscape) do |pdf|
  
  qr_url = 'http://chart.apis.google.com/chart?cht=qr&chs=140x140&choe=UTF-8&chld=H%7C0&chl=' + CGI::escape(show_by_code_url(@wall.code))
  qr_img = open(qr_url)
  pdf.image qr_img, :at => [0, 480]

  pdf.bounding_box [155, 535], :width => 210, :height => 250 do |b|
  	pdf.font(Rails.root.join('app', 'assets', 'fonts', 'ContrailOne-Regular.ttf')) do
  		pdf.font_size 28
  		pdf.text @wall.title
  	end
  end

  pdf.stroke_color 'cccccc'
  half_a4_height = 420.94488189
  half_a4_width = 297.637795276
  pdf.stroke_rectangle [-37, 577], half_a4_height, half_a4_width
  
  pdf.font(Rails.root.join('app', 'assets', 'fonts', 'ReenieBeanie.ttf')) do
      pdf.fill_color '023fef'
	  pdf.text_box("QR code contains dicussion forum! \nScan to see what others think!",
	          :at => [0, 524], :width => 300, :height => 50,
	          :rotate => 7, :rotate_around => :center, :mode => :fill)
	  
	  pdf.fill_color 'ef0202'
	  pdf.text_box("Instructions\n1. Print this document and cut out the rectangle to the left.\n2. Put it up in a public place.\n3. Await awesome!",
	          :at => [410, 524], :width => 300, :height => 200,
	          :rotate => 7, :rotate_around => :center, :mode => :fill,
	          :size => 20)
  end






end
