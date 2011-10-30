class PostsController < ApplicationController


  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])


    respond_to do |format|
      if @post.save
        wall = Wall.find params[:post][:wall_id]
        @post.wall.subscriptions.each do |sub|
          if sub.confirmed
            unsuburl = unsubscribe_url(sub.id, sub.secret)
            Pony.mail(:from => "QRum Robot <robot@qrum.se>",
                  :to => sub.email,
                  :subject =>  "New comment on " + wall.title,
                  :html_body => "<span style=\"font-family: sans-serif\">
                  New comment on <a href=\"#{wall_url(wall)}\">#{wall.title}</a><br/>
                  <hr /><br />
                  #{@post.body}
                  <br /><br />
                  - #{@post.signature}
                  <hr /><br />
                  <a href=\"#{unsuburl}\">Stop emailing me about this!</a>
                  </span>
                  ")
          end
        end
            
        format.html { redirect_to show_by_code_url(@post.wall.code), 
                      notice: "Your comment has been posted to the wall. 
                      Don't forget to press the subscribe button below so that 
                      you'll know when someone responds!" }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

end
