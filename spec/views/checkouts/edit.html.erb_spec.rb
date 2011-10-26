require 'spec_helper'

describe "checkouts/edit.html.erb" do
  before(:each) do
    @checkout = assign(:checkout, stub_model(Checkout,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogs => 1
    ))
  end

  it "renders the edit checkout form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkout_path(@checkout), :method => "post" do
      assert_select "input#checkout_musher_id", :name => "checkout[musher_id]"
      assert_select "input#checkout_checkpoint_id", :name => "checkout[checkpoint_id]"
      assert_select "input#checkout_dogs", :name => "checkout[dogs]"
    end
  end
end
