require 'spec_helper'

describe "logos/index" do
  before(:each) do
    assign(:logos, [
      stub_model(Logo,
        :nick => "Nick"
      ),
      stub_model(Logo,
        :nick => "Nick"
      )
    ])
  end

  it "renders a list of logos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nick".to_s, :count => 2
  end
end
