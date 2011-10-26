require 'spec_helper'

describe "updates/index.html.erb" do
  before(:each) do
    assign(:updates, [
      stub_model(Update,
        :musher_id => 1,
        :checkpoint_id => 1,
        :dogsin => 1,
        :dogsout => 1
      ),
      stub_model(Update,
        :musher_id => 1,
        :checkpoint_id => 1,
        :dogsin => 1,
        :dogsout => 1
      )
    ])
  end

  it "renders a list of updates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
