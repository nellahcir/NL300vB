require 'spec_helper'

describe "checkins/show.html.erb" do
  before(:each) do
    @checkin = assign(:checkin, stub_model(Checkin,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogs => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
