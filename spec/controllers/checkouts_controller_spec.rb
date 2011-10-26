require 'spec_helper'

describe CheckoutsController do

  def mock_checkout(stubs={})
    (@mock_checkout ||= mock_model(Checkout).as_null_object).tap do |checkout|
      checkout.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all checkouts as @checkouts" do
      Checkout.stub(:all) { [mock_checkout] }
      get :index
      assigns(:checkouts).should eq([mock_checkout])
    end
  end

  describe "GET show" do
    it "assigns the requested checkout as @checkout" do
      Checkout.stub(:find).with("37") { mock_checkout }
      get :show, :id => "37"
      assigns(:checkout).should be(mock_checkout)
    end
  end

  describe "GET new" do
    it "assigns a new checkout as @checkout" do
      Checkout.stub(:new) { mock_checkout }
      get :new
      assigns(:checkout).should be(mock_checkout)
    end
  end

  describe "GET edit" do
    it "assigns the requested checkout as @checkout" do
      Checkout.stub(:find).with("37") { mock_checkout }
      get :edit, :id => "37"
      assigns(:checkout).should be(mock_checkout)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created checkout as @checkout" do
        Checkout.stub(:new).with({'these' => 'params'}) { mock_checkout(:save => true) }
        post :create, :checkout => {'these' => 'params'}
        assigns(:checkout).should be(mock_checkout)
      end

      it "redirects to the created checkout" do
        Checkout.stub(:new) { mock_checkout(:save => true) }
        post :create, :checkout => {}
        response.should redirect_to(checkout_url(mock_checkout))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved checkout as @checkout" do
        Checkout.stub(:new).with({'these' => 'params'}) { mock_checkout(:save => false) }
        post :create, :checkout => {'these' => 'params'}
        assigns(:checkout).should be(mock_checkout)
      end

      it "re-renders the 'new' template" do
        Checkout.stub(:new) { mock_checkout(:save => false) }
        post :create, :checkout => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested checkout" do
        Checkout.should_receive(:find).with("37") { mock_checkout }
        mock_checkout.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :checkout => {'these' => 'params'}
      end

      it "assigns the requested checkout as @checkout" do
        Checkout.stub(:find) { mock_checkout(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:checkout).should be(mock_checkout)
      end

      it "redirects to the checkout" do
        Checkout.stub(:find) { mock_checkout(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(checkout_url(mock_checkout))
      end
    end

    describe "with invalid params" do
      it "assigns the checkout as @checkout" do
        Checkout.stub(:find) { mock_checkout(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:checkout).should be(mock_checkout)
      end

      it "re-renders the 'edit' template" do
        Checkout.stub(:find) { mock_checkout(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested checkout" do
      Checkout.should_receive(:find).with("37") { mock_checkout }
      mock_checkout.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the checkouts list" do
      Checkout.stub(:find) { mock_checkout }
      delete :destroy, :id => "1"
      response.should redirect_to(checkouts_url)
    end
  end

end
