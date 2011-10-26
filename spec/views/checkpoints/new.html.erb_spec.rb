require 'spec_helper'

describe "checkpoints/new.html.erb" do
  before(:each) do
    assign(:checkpoint, stub_model(Checkpoint,
      :name => "MyString",
      :sequence => 1,
      :milepost => 1
    ).as_new_record)
  end

  it "renders new checkpoint form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkpoints_path, :method => "post" do
      assert_select "input#checkpoint_name", :name => "checkpoint[name]"
      assert_select "input#checkpoint_sequence", :name => "checkpoint[sequence]"
      assert_select "input#checkpoint_milepost", :name => "checkpoint[milepost]"
    end
  end
end
