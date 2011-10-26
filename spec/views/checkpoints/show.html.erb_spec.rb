require 'spec_helper'

describe "checkpoints/show.html.erb" do
  before(:each) do
    @checkpoint = assign(:checkpoint, stub_model(Checkpoint,
      :name => "Name",
      :sequence => 1,
      :milepost => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
