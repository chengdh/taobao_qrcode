#coding: utf-8
FactoryGirl.define do
  factory :item,:class => TaobaoSDK::Item do
    num_iid   1
    title     '测试商品'
    pic_url "http://127.0.0.1/test_item.jpeg"
    detail_url "http://127.0.0.1/test_item"
    desc      'this is a mock item'
  end

  #taobao.items.onsale.get
  factory :items_onsale_get_response,:class => TaobaoSDK::ItemsOnsaleGetResponse do
    total_results 1
    items [FactoryGirl.build(:item)]
  end

  #sellercat
  factory :seller_cat_1,:class => TaobaoSDK::SellerCat do
    type 'manual_type'
    parent_cid 0
    cid 0
    name '店铺分类1'
  end
  factory :seller_cat_2,:class => TaobaoSDK::SellerCat do
    type 'manual_type'
    parent_cid 0
    cid 1
    name '店铺分类2'
  end
  #taobao.sellercats.list.get
  factory :sellercats_list_get_response,:class => TaobaoSDK::SellercatsListGetResponse do
    seller_cats  [FactoryGirl.build(:seller_cat_1),FactoryGirl.build(:seller_cat_2)]
  end

  #taobao.item.get
  factory :item_get_response,:class => TaobaoSDK::ItemGetResponse do
    item FactoryGirl.build(:item)
  end
  #taobao.item.update
  factory :item_update_response,:class => TaobaoSDK::ItemUpdateResponse do
    item FactoryGirl.build(:item)
  end
  factory :item_img,:class => TaobaoSDK::ItemImg do
    id 12345
    url "http://127.0.0.1/a.png"
  end
  #taobao.item.img.upload
  factory :item_img_upload_response,:class => TaobaoSDK::ItemImgUploadResponse do
    item_img FactoryGirl.build(:item_img)
  end

end
