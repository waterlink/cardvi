require 'spec_helper'

describe "cards/new" do
  before(:each) do
    assign(:card, stub_model(Card,
      :name => "MyString",
      :content => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cards_path, :method => "post" do
      assert_select "input#card_name", :name => "card[name]"
      assert_select "input#card_content", :name => "card[content]"
      assert_select "input#card_user_id", :name => "card[user_id]"
    end
  end
end
