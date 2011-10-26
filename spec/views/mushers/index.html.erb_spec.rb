require 'spec_helper'

describe "mushers/index.html.erb" do
  before(:each) do
    assign(:mushers, [
      stub_model(Musher,
        :name => "Name",
        :bibnum => 1,
        :dogs => 1,
        :year => 1,
        :stpos => 1,
        :status_id => 1
      ),
      stub_model(Musher,
        :name => "Name",
        :bibnum => 1,
        :dogs => 1,
        :year => 1,
        :stpos => 1,
        :status_id => 1
      )
    ])
  end

  it "renders a list of mushers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
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
