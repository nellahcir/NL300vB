require 'spec_helper'

describe MushersController do

  def mock_musher(stubs={})
    (@mock_musher ||= mock_model(Musher).as_null_object).tap do |musher|
      musher.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all mushers as @mushers" do
      Musher.stub(:all) { [mock_musher] }
      get :index
      assigns(:mushers).should eq([mock_musher])
    end
  end

  describe "GET show" do
    it "assigns the requested musher as @musher" do
      Musher.stub(:find).with("37") { mock_musher }
      get :show, :id => "37"
      assigns(:musher).should be(mock_musher)
    end
  end

  describe "GET new" do
    it "assigns a new musher as @musher" do
      Musher.stub(:new) { mock_musher }
      get :new
      assigns(:musher).should be(mock_musher)
    end
  end

  describe "GET edit" do
    it "assigns the requested musher as @musher" do
      Musher.stub(:find).with("37") { mock_musher }
      get :edit, :id => "37"
      assigns(:musher).should be(mock_musher)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created musher as @musher" do
        Musher.stub(:new).with({'these' => 'params'}) { mock_musher(:save => true) }
        post :create, :musher => {'these' => 'params'}
        assigns(:musher).should be(mock_musher)
      end

      it "redirects to the created musher" do
        Musher.stub(:new) { mock_musher(:save => true) }
        post :create, :musher => {}
        response.should redirect_to(musher_url(mock_musher))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved musher as @musher" do
        Musher.stub(:new).with({'these' => 'params'}) { mock_musher(:save => false) }
        post :create, :musher => {'these' => 'params'}
        assigns(:musher).should be(mock_musher)
      end

      it "re-renders the 'new' template" do
        Musher.stub(:new) { mock_musher(:save => false) }
        post :create, :musher => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested musher" do
        Musher.should_receive(:find).with("37") { mock_musher }
        mock_musher.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :musher => {'these' => 'params'}
      end

      it "assigns the requested musher as @musher" do
        Musher.stub(:find) { mock_musher(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:musher).should be(mock_musher)
      end

      it "redirects to the musher" do
        Musher.stub(:find) { mock_musher(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(musher_url(mock_musher))
      end
    end

    describe "with invalid params" do
      it "assigns the musher as @musher" do
        Musher.stub(:find) { mock_musher(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:musher).should be(mock_musher)
      end

      it "re-renders the 'edit' template" do
        Musher.stub(:find) { mock_musher(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested musher" do
      Musher.should_receive(:find).with("37") { mock_musher }
      mock_musher.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the mushers list" do
      Musher.stub(:find) { mock_musher }
      delete :destroy, :id => "1"
      response.should redirect_to(mushers_url)
    end
  end

end
