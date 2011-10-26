require 'spec_helper'

describe "standings/edit.html.erb" do
  before(:each) do
    @standing = assign(:standing, stub_model(Standing,
      :a => "MyString"
    ))
  end

  it "renders the edit standing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => standing_path(@standing), :method => "post" do
      assert_select "input#standing_a", :name => "standing[a]"
    end
  end
end
