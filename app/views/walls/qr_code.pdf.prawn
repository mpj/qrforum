#<h2>Discuss this shit online:</h2>
#<h1><%= @wall.title %></h1>
#<img src=" %>" />

require "open-uri"

prawn_document(:page_layout => :portrait, :margin => 0) do |pdf|
  
  a4width = 595.275590552
  a4height = 841.88976378
  margin = 50

  contrail_path = Rails.root.join('app', 'assets', 'fonts', 'ContrailOne-Regular.ttf')
  arimo_regular_path = Rails.root.join('app', 'assets', 'fonts', 'Arimo-Regular.ttf')
  arimo_bold_path = Rails.root.join('app', 'assets', 'fonts', 'Arimo-Bold.ttf')

  pdf.bounding_box [margin, 740], :width => a4width-(margin*2) do |b|
    pdf.font(contrail_path) do
      pdf.font_size 40
      pdf.text @wall.title, :align => :center
    end
  end

  qr_size = 150
  margin = 40
  pdf.bounding_box  [0, pdf.cursor-margin], 
                    :width => a4width, :height => qr_size+margin do |b|
    qr_url = 'http://chart.apis.google.com/chart?cht=qr&chs=500x500&choe=UTF-8&chld=H%7C0&chl=' + CGI::escape(show_by_code_url(@wall.code))
    qr_img = open(qr_url)
    pdf.image qr_img, :width => qr_size, :height => qr_size, :position => :center
  end
  
  triangle_base = 30
  triangle_height = 20
  pdf.fill_polygon [a4width/2-triangle_base/2, pdf.cursor], 
                   [a4width/2, pdf.cursor+triangle_height], 
                   [a4width/2+triangle_base/2, pdf.cursor]

  rect_width = 250
  rect_height = 60
  left = a4width / 2 - rect_width / 2
  margin_x = 20
  margin_y = 10
  pdf.fill_rectangle [left, pdf.cursor], rect_width, rect_height

  pdf.bounding_box  [left+margin_x, pdf.cursor-margin_y], 
                    :width => rect_width-margin_x*2 do |b|
    pdf.fill_color 'ffffff'
    pdf.font_size 10
    pdf.font(arimo_bold_path) do
      pdf.text "Discussion forum inside this QR code!", :align => :center, :mode => :fill
    end
    pdf.font(arimo_regular_path) do
      pdf.text "Scan it with a QR reader app to write what you think, or to read what others thought.", 
                :align => :center, :mode => :fill
    end

  end



  
  #pdf.font(Rails.root.join('app', 'assets', 'fonts', 'ReenieBeanie.ttf')) do
  #    pdf.fill_color '023fef'
	#  pdf.text_box("QR code contains dicussion forum! \nScan to see what others think!",
	#          :at => [0, 524], :width => 300, :height => 50,
	#          :rotate => 7, :rotate_around => :center, :mode => :fill)
	#  
	#  pdf.fill_color 'ef0202'
	#  pdf.text_box("Instructions\n1. Print this document and cut out the rectangle to the left.\n2. Put it up in a public place.\n3. Await awesome!",
	#          :at => [410, 524], :width => 300, :height => 200,
	#          :rotate => 7, :rotate_around => :center, :mode => :fill,
	#          :size => 20)
  #end

end
