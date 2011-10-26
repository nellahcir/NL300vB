require 'spec_helper'

describe "standings/new.html.erb" do
  before(:each) do
    assign(:standing, stub_model(Standing,
      :a => "MyString"
    ).as_new_record)
  end

  it "renders new standing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => standings_path, :method => "post" do
      assert_select "input#standing_a", :name => "standing[a]"
    end
  end
end
