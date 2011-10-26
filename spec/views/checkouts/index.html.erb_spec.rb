require 'spec_helper'

describe "checkouts/index.html.erb" do
  before(:each) do
    assign(:checkouts, [
      stub_model(Checkout,
        :musher_id => 1,
        :checkpoint_id => 1,
        :dogs => 1
      ),
      stub_model(Checkout,
        :musher_id => 1,
        :checkpoint_id => 1,
        :dogs => 1
      )
    ])
  end

  it "renders a list of checkouts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
