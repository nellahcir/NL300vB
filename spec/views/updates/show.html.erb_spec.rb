require 'spec_helper'

describe "updates/show.html.erb" do
  before(:each) do
    @update = assign(:update, stub_model(Update,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogsin => 1,
      :dogsout => 1
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
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
