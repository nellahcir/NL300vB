require 'spec_helper'

describe "checkins/new.html.erb" do
  before(:each) do
    assign(:checkin, stub_model(Checkin,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogs => 1
    ).as_new_record)
  end

  it "renders new checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkins_path, :method => "post" do
      assert_select "input#checkin_musher_id", :name => "checkin[musher_id]"
      assert_select "input#checkin_checkpoint_id", :name => "checkin[checkpoint_id]"
      assert_select "input#checkin_dogs", :name => "checkin[dogs]"
    end
  end
end
