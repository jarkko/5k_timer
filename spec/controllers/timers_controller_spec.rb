require 'spec_helper'

describe TimersController do

  def mock_timer(stubs={})
    @mock_timer ||= mock_model(Timer, stubs)
  end

  describe "GET index" do
    it "assigns all timers as @timers" do
      Timer.stub!(:find).with(:all).and_return([mock_timer])
      get :index
      assigns[:timers].should == [mock_timer]
    end
  end

  describe "GET show" do
    it "assigns the requested timer as @timer" do
      Timer.stub!(:find).with("37").and_return(mock_timer)
      get :show, :id => "37"
      assigns[:timer].should equal(mock_timer)
    end
  end

  describe "GET new" do
    it "assigns a new timer as @timer" do
      Timer.stub!(:new).and_return(mock_timer)
      get :new
      assigns[:timer].should equal(mock_timer)
    end
  end

  describe "GET edit" do
    it "assigns the requested timer as @timer" do
      Timer.stub!(:find).with("37").and_return(mock_timer)
      get :edit, :id => "37"
      assigns[:timer].should equal(mock_timer)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created timer as @timer" do
        Timer.stub!(:new).with({'these' => 'params'}).and_return(mock_timer(:save => true))
        post :create, :timer => {:these => 'params'}
        assigns[:timer].should equal(mock_timer)
      end

      it "redirects to the created timer" do
        Timer.stub!(:new).and_return(mock_timer(:save => true))
        post :create, :timer => {}
        response.should redirect_to(timer_url(mock_timer))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved timer as @timer" do
        Timer.stub!(:new).with({'these' => 'params'}).and_return(mock_timer(:save => false))
        post :create, :timer => {:these => 'params'}
        assigns[:timer].should equal(mock_timer)
      end

      it "re-renders the 'new' template" do
        Timer.stub!(:new).and_return(mock_timer(:save => false))
        post :create, :timer => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested timer" do
        Timer.should_receive(:find).with("37").and_return(mock_timer)
        mock_timer.should_receive(:update).with({'these' => 'params'})
        put :update, :id => "37", :timer => {:these => 'params'}
      end

      it "assigns the requested timer as @timer" do
        Timer.stub!(:find).and_return(mock_timer(:update => true))
        put :update, :id => "1"
        assigns[:timer].should equal(mock_timer)
      end

      it "redirects to the timer" do
        Timer.stub!(:find).and_return(mock_timer(:update => true))
        put :update, :id => "1"
        response.should redirect_to(timer_url(mock_timer))
      end
    end

    describe "with invalid params" do
      it "updates the requested timer" do
        Timer.should_receive(:find).with("37").and_return(mock_timer)
        mock_timer.should_receive(:update).with({'these' => 'params'})
        put :update, :id => "37", :timer => {:these => 'params'}
      end

      it "assigns the timer as @timer" do
        Timer.stub!(:find).and_return(mock_timer(:update => false))
        put :update, :id => "1"
        assigns[:timer].should equal(mock_timer)
      end

      it "re-renders the 'edit' template" do
        Timer.stub!(:find).and_return(mock_timer(:update => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested timer" do
      Timer.should_receive(:find).with("37").and_return(mock_timer)
      mock_timer.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the timers list" do
      Timer.stub!(:find).and_return(mock_timer(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(timers_url)
    end
  end

end
