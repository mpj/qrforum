require 'prawn'

class WallsController < ApplicationController
  # GET /walls
  # GET /walls.json
  def index
    @walls = Wall.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @walls }
    end
  end

  def show_by_code
    
    @wall = Wall.find_by_code(params[:code])

    if not session[:visitor_counted]
      if @wall.views 
        @wall.views = @wall.views + 1
      else
        @wall.views = 1
      end
      @wall.save
      session[:visitor_counted] = true
    end

    @latest_posts = Post.where(:wall_id => @wall.id)
    @post = Post.new(:wall_id => @wall.id)
    @post.wall = @wall

    respond_to do |format|
      format.html { render :action => :show }
      format.json { render json: @wall }
    end
  end

  def qr_code
    @wall = Wall.find_by_code params[:code]
  end

  # GET /walls/new
  # GET /walls/new.json
  def new
    @wall = Wall.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wall }
    end
  end

  # POST /walls
  # POST /walls.json
  def create
    @wall = Wall.new(params[:wall])
    @wall.code = SecureRandom.hex(8).force_encoding('UTF-8')[0,8]

    respond_to do |format|
      if @wall.save
        format.html { redirect_to wall_qr_url(@wall.code, :format => :pdf), notice: 'Wall was successfully created.' }
        format.json { render json: @wall, status: :created, location: @wall }
      else
        format.html { render action: "new" }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

end
