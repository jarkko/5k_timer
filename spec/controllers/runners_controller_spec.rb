require 'spec_helper'

describe RunnersController do

  def mock_runner(stubs={})
    @mock_runner ||= mock_model(Runner, stubs)
  end

  describe "GET index" do
    it "assigns all runners as @runners" do
      Runner.stub!(:find).with(:all).and_return([mock_runner])
      get :index
      assigns[:runners].should == [mock_runner]
    end
  end

  describe "GET show" do
    it "assigns the requested runner as @runner" do
      Runner.stub!(:find).with("37").and_return(mock_runner)
      get :show, :id => "37"
      assigns[:runner].should equal(mock_runner)
    end
  end

  describe "GET new" do
    it "assigns a new runner as @runner" do
      Runner.stub!(:new).and_return(mock_runner)
      get :new
      assigns[:runner].should equal(mock_runner)
    end
  end

  describe "GET edit" do
    it "assigns the requested runner as @runner" do
      Runner.stub!(:find).with("37").and_return(mock_runner)
      get :edit, :id => "37"
      assigns[:runner].should equal(mock_runner)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created runner as @runner" do
        Runner.stub!(:new).with({'these' => 'params'}).and_return(mock_runner(:save => true))
        post :create, :runner => {:these => 'params'}
        assigns[:runner].should equal(mock_runner)
      end

      it "redirects to the created runner" do
        Runner.stub!(:new).and_return(mock_runner(:save => true))
        post :create, :runner => {}
        response.should redirect_to(runner_url(mock_runner))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved runner as @runner" do
        Runner.stub!(:new).with({'these' => 'params'}).and_return(mock_runner(:save => false))
        post :create, :runner => {:these => 'params'}
        assigns[:runner].should equal(mock_runner)
      end

      it "re-renders the 'new' template" do
        Runner.stub!(:new).and_return(mock_runner(:save => false))
        post :create, :runner => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested runner" do
        Runner.should_receive(:find).with("37").and_return(mock_runner)
        mock_runner.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :runner => {:these => 'params'}
      end

      it "assigns the requested runner as @runner" do
        Runner.stub!(:find).and_return(mock_runner(:update_attributes => true))
        put :update, :id => "1"
        assigns[:runner].should equal(mock_runner)
      end

      it "redirects to the runner" do
        Runner.stub!(:find).and_return(mock_runner(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(runner_url(mock_runner))
      end
    end

    describe "with invalid params" do
      it "updates the requested runner" do
        Runner.should_receive(:find).with("37").and_return(mock_runner)
        mock_runner.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :runner => {:these => 'params'}
      end

      it "assigns the runner as @runner" do
        Runner.stub!(:find).and_return(mock_runner(:update_attributes => false))
        put :update, :id => "1"
        assigns[:runner].should equal(mock_runner)
      end

      it "re-renders the 'edit' template" do
        Runner.stub!(:find).and_return(mock_runner(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested runner" do
      Runner.should_receive(:find).with("37").and_return(mock_runner)
      mock_runner.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the runners list" do
      Runner.stub!(:find).and_return(mock_runner(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(runners_url)
    end
  end

end
