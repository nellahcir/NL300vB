require 'spec_helper'

describe "updates/new.html.erb" do
  before(:each) do
    assign(:update, stub_model(Update,
      :musher_id => 1,
      :checkpoint_id => 1,
      :dogsin => 1,
      :dogsout => 1
    ).as_new_record)
  end

  it "renders new update form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => updates_path, :method => "post" do
      assert_select "input#update_musher_id", :name => "update[musher_id]"
      assert_select "input#update_checkpoint_id", :name => "update[checkpoint_id]"
      assert_select "input#update_dogsin", :name => "update[dogsin]"
      assert_select "input#update_dogsout", :name => "update[dogsout]"
    end
  end
end
