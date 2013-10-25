#coding: utf-8
module ShopsHelper
  #根据店铺sid获取店铺网址
  def shop_url(sid)
    "http://shop#{sid}.taobao.com"
  end
  #得到店标url
  def shop_logo_url(logo_path)
    "http://logo.taobao.com/shop-logo#{logo_path}"
  end
  #店铺网址共享json对象
  #qr_content 二维码
  def shop_share_json(shop)
    {
      pic:    short_url(public_qr_code_service_shops_url(content: shop_url(shop.sid))),
      text:   "#{shop.title}-诚信卖家,扫描二维码进店选购",
      url:    short_url(public_qr_code_service_shops_url(content: shop_url(shop.sid))),
      comment: shop.desc
    }.to_json
  end
  #店铺名片共享json对象
  def shop_card_share_json(shop_card)
    {
      pic:    short_url(public_qr_code_service_shops_url(content: shop_card.build_vcard.to_s)),
      text:   "#{shop_card.title}-诚信淘宝卖家,扫描二维码进店选购",
      url:    short_url(public_qr_code_service_shops_url(content: shop_card.build_vcard.to_s)),
      comment: shop_card.shop_desc
    }.to_json
  end
end
