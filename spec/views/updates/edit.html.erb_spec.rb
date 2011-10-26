require 'spec_helper'

describe "updates/edit.html.erb" do
  before(:each) do
    @update = assign(:update, stub_model(Update,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogsin => 1,
      :dogsout => 1
    ))
  end

  it "renders the edit update form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => update_path(@update), :method => "post" do
      assert_select "input#update_musher_id", :name => "update[musher_id]"
      assert_select "input#update_checkpoint_id", :name => "update[checkpoint_id]"
      assert_select "input#update_dogsin", :name => "update[dogsin]"
      assert_select "input#update_dogsout", :name => "update[dogsout]"
    end
  end
end
