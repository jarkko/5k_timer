class ResultsController < ApplicationController
  # GET /results
  # GET /results.xml
  def index
    @timer = Timer.find(params[:timer_id])
    
    opts = {}
    
    if params[:result_ids]
      opts[:conditions] = {:id => params[:result_ids]}
    end
    
    @results = @timer.results.find(:all, opts).select{ |res| res.name.present? }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
      format.json { render :json => @results.to_json(:methods => :name)}
    end
  end

  # GET /results/1
  # GET /results/1.xml
  def show
    @result = Result.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result }
      format.json { render :json => @result.to_json(:methods => :name) }
    end
  end

  # GET /results/new
  # GET /results/new.xml
  def new
    @result = Result.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/1/edit
  def edit
    @result = Result.find(params[:id])
  end

  # POST /results
  # POST /results.xml
  def create
    @result = Result.new(params[:result])

    respond_to do |format|
      if @result.save
        format.html do
          flash[:notice] = 'Result was successfully created.'
          
          redirect_to(@result)
        end
        format.xml  { render :xml => @result, :status => :created, :location => @result }
        format.json { render :json => @result.to_json }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.xml
  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        flash[:notice] = 'Result was successfully updated.'
        format.html { redirect_to(@result) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.xml
  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to(results_url) }
      format.xml  { head :ok }
    end
  end
end
