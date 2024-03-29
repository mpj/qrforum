class SubscriptionsController < ApplicationController

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new
    @subscription.email = params[:email]
    @subscription.wall = Wall.find_by_id params[:id]
    @subscription.secret = SecureRandom.hex(8).force_encoding('UTF-8')[0,8]

    respond_to do |format|
      if @subscription.save

        confirm_url = confirm_subscription_url(:id => @subscription.id, :secret => @subscription.secret)
        Pony.mail(:from => "QRum Robot <robot@qrum.se>",
                  :to => @subscription.email,
                  :subject =>  "Confirm subscription: " + @subscription.wall.title,
                  :html_body => "<span style=\"font-family: sans-serif\"><h1>One step left!</h1>
                  <a href=\"#{confirm_url}\">Click here to confirm</a> that you really want 
                  to <br />receive updates to <b>#{@subscription.wall.title}.<br /><br />
                  - The little QRum robot
                  </span>
                  ")

        render json: @subscription, status: :created, location: @subscription
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
      qrurl = show_by_code_url(@subscription.wall.code)
      redirect_to qrurl, notice: 'Confirmed! You will now get email updates when comments are posted on this QRum.'
    else
      render :status => :forbidden
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

  def unsubscribe
    @subscription = Subscription.find params[:id]
    if params[:secret] == @subscription.secret
      @subscription.destroy
    end
  end

  def unsubscribe_all
    subs = Subscription.where :email => params[:email]
    logger.info "email"+ params[:email]
    if subs.length > 0
      subs.each do |s|
        s.destroy
      end
    end
  end

end
