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

  # GET /walls/1/edit
  def edit
    @wall = Wall.find(params[:id])
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

  # PUT /walls/1
  # PUT /walls/1.json
  def update
    @wall = Wall.find(params[:id])

    respond_to do |format|
      if @wall.update_attributes(params[:wall])
        format.html { redirect_to @wall, notice: 'Wall was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /walls/1
  # DELETE /walls/1.json
  def destroy
    @wall = Wall.find(params[:id])
    @wall.destroy

    respond_to do |format|
      format.html { redirect_to walls_url }
      format.json { head :ok }
    end
  end
end
