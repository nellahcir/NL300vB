require 'spec_helper'

describe "mushers/new.html.erb" do
  before(:each) do
    assign(:musher, stub_model(Musher,
      :name => "MyString",
      :bibnum => 1,
      :dogs => 1,
      :year => 1,
      :stpos => 1,
      :status_id => 1
    ).as_new_record)
  end

  it "renders new musher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mushers_path, :method => "post" do
      assert_select "input#musher_name", :name => "musher[name]"
      assert_select "input#musher_bibnum", :name => "musher[bibnum]"
      assert_select "input#musher_dogs", :name => "musher[dogs]"
      assert_select "input#musher_year", :name => "musher[year]"
      assert_select "input#musher_stpos", :name => "musher[stpos]"
      assert_select "input#musher_status_id", :name => "musher[status_id]"
    end
  end
end
