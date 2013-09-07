#coding: utf-8
FactoryGirl.define do
  factory :item,:class => TaobaoSDK::Item do
    num_iid   1
    title     '测试商品'
  end

  factory :items_onsale_get_response,:class => TaobaoSDK::ItemsOnsaleGetResponse do
    total_results 1
    items [FactoryGirl.build(:item)]
  end
end
