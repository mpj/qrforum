class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new
    @subscription.email = params[:email]
    @subscription.wall = Wall.find_by_id params[:id]
    @subscription.secret = SecureRandom.hex(8).force_encoding('UTF-8')[0,8]

    respond_to do |format|
      if @subscription.save

        Pony.options = {
          :via => :smtp,
          :via_options => {
            :address => 'smtp.sendgrid.net',
            :port => '587',
            :domain => 'heroku.com',
            :user_name => ENV['SENDGRID_USERNAME'],
            :password => ENV['SENDGRID_PASSWORD'],
            :authentication => :plain,
            :enable_starttls_auto => true
          }
        }

        confirm_url = confirm_subscription_url(:id => @subscription.id, :secret => @subscription.secret)
        Pony.mail(:from => "noreply@qrum.se",
                  :to => @subscription.email,
                  :subject => @subscription.wall.title + " (confirm subscription)",
                  :html_body => "<span style=\"font-family: sans-serif\"><h1>One step left!</h1><br />
                  To confirm that you really want to receive updates to <b>#{@subscription.wall.title}
                  </b>,<a href=\"#{confirm_url}\">click here</a>.<br /><br />
                  - The little QRum robot
                  </span>
                  ")

        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @subscription = Subscription.find(params[:id])
    if @subscription and @subscription.secret == params[:secret]
      @subscription.confirmed = true
      @subscription.save
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :ok }
    end
  end
end
