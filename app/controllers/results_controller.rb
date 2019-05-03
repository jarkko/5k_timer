class ResultsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /results
  # GET /results.xml
  def index
    if params[:timer_id]
      @timer = Timer.find(params[:timer_id])
    else
      return redirect_to timer_results_path(Timer.last)
    end

    scope = @timer.results.order("result asc")

    if params[:result_ids]
      scope = scope.where(id: params[:result_ids])
    end

    if params[:min_id]
      scope = scope.newer_than(params[:min_id])
    end

    if params[:category_id]
      @results = scope.in_category(params[:category_id])
    else
      @results = scope
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
      format.json do
        if params[:with_names]
          @results = @results.select{ |res| res.name.present? }
        end
        render :json => @results.to_json(:methods => [:name, :bib_number, :category_name])
      end
      format.js do
        render :partial => @results
      end
    end
  end

  # GET /results/1
  # GET /results/1.xml
  def show
    @result = Result.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result }
      format.json { render :json => @result.to_json(:methods => [:name, :category_name, :category_position]) }
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
    @result = Result.new(result_params)

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
        format.json  { render :json => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.xml
  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(result_params)
        format.js { render :partial => @result }
        format.json { render :json => @result.to_json(:methods => [:name, :bib_number, :category_name]) }
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

  private

  def result_params
    params.require(:result).permit(:result, :timer_id, :bib_number)
  end
end
