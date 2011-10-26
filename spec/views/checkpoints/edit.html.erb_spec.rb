require 'spec_helper'

describe "checkpoints/edit.html.erb" do
  before(:each) do
    @checkpoint = assign(:checkpoint, stub_model(Checkpoint,
      :name => "MyString",
      :sequence => 1,
      :milepost => 1
    ))
  end

  it "renders the edit checkpoint form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkpoint_path(@checkpoint), :method => "post" do
      assert_select "input#checkpoint_name", :name => "checkpoint[name]"
      assert_select "input#checkpoint_sequence", :name => "checkpoint[sequence]"
      assert_select "input#checkpoint_milepost", :name => "checkpoint[milepost]"
    end
  end
end
