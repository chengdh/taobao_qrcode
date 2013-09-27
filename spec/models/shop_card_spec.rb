#coding: utf-8
require 'spec_helper'

describe ShopCard do
  it "应可正确保存shop_card" do
    shop_card = FactoryGirl.build(:shop_card)
    shop_card.save!
  end
  it "应可正确生成vcard数据" do
    shop_card = FactoryGirl.create(:shop_card)
    vcard = shop_card.build_vcard
    vcard.should be_present
  end
end
