require 'spec_helper'

describe "checkins/edit.html.erb" do
  before(:each) do
    @checkin = assign(:checkin, stub_model(Checkin,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogs => 1
    ))
  end

  it "renders the edit checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkin_path(@checkin), :method => "post" do
      assert_select "input#checkin_musher_id", :name => "checkin[musher_id]"
      assert_select "input#checkin_checkpoint_id", :name => "checkin[checkpoint_id]"
      assert_select "input#checkin_dogs", :name => "checkin[dogs]"
    end
  end
end
