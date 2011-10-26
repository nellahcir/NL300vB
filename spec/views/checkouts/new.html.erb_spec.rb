require 'spec_helper'

describe "checkouts/new.html.erb" do
  before(:each) do
    assign(:checkout, stub_model(Checkout,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogs => 1
    ).as_new_record)
  end

  it "renders new checkout form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkouts_path, :method => "post" do
      assert_select "input#checkout_musher_id", :name => "checkout[musher_id]"
      assert_select "input#checkout_checkpoint_id", :name => "checkout[checkpoint_id]"
      assert_select "input#checkout_dogs", :name => "checkout[dogs]"
    end
  end
end
