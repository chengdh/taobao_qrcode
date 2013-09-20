require 'spec_helper'

describe "logos/edit" do
  before(:each) do
    @logo = assign(:logo, stub_model(Logo,
      :nick => "MyString"
    ))
  end

  it "renders the edit logo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", logo_path(@logo), "post" do
      assert_select "input#logo_nick[name=?]", "logo[nick]"
    end
  end
end
