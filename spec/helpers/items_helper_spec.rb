require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ItemsHelper. For example:
#
# describe ItemsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ItemsHelper do
  before(:each){set_taobao_access_token}
  let!(:sellercats_list_get_response) {FactoryGirl.build(:sellercats_list_get_response)}
  it "#sellercats_for_select" do
    TaobaoSDK::Session.should_receive(:invoke).and_return(sellercats_list_get_response)
    helper.sellercats_for_select.should_not be_blank
  end
end
