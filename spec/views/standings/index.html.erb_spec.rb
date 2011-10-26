require 'spec_helper'

describe "standings/index.html.erb" do
  before(:each) do
    assign(:standings, [
      stub_model(Standing,
        :a => "A"
      ),
      stub_model(Standing,
        :a => "A"
      )
    ])
  end

  it "renders a list of standings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "A".to_s, :count => 2
  end
end
