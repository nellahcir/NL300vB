require 'spec_helper'

describe "standings/show.html.erb" do
  before(:each) do
    @standing = assign(:standing, stub_model(Standing,
      :a => "A"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/A/)
  end
end
