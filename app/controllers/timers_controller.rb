class TimersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /timers
  # GET /timers.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /timers/1
  # GET /timers/1.xml
  def show
    @timer = Timer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timer }
    end
  end

  # GET /timers/new
  # GET /timers/new.xml
  def new
    @timer = Timer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timer }
    end
  end

  # GET /timers/1/edit
  def edit
    @timer = Timer.find(params[:id])
  end

  # POST /timers
  # POST /timers.xml
  def create
    @timer = Timer.new(timer_params)

    respond_to do |format|
      if @timer.save
        format.html do
          redirect_to(@timer)
          flash[:notice] = 'Timer was successfully created.'
        end
        format.xml  { render :xml => @timer, :status => :created, :location => @timer }
        format.json { render :json => @timer.to_json}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timers/1
  # PUT /timers/1.xml
  def update
    @timer = Timer.find(params[:id])

    respond_to do |format|
      if @timer.update_attributes(params[:timer])
        flash[:notice] = 'Timer was successfully updated.'
        format.html { redirect_to(@timer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timers/1
  # DELETE /timers/1.xml
  def destroy
    @timer = Timer.find(params[:id])
    @timer.destroy

    respond_to do |format|
      format.html { redirect_to(timers_url) }
      format.xml  { head :ok }
    end
  end

  private

  def timer_params
    params.require(:timer).permit(:start_time)
  end
end
