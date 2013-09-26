#coding: utf-8
module ShopsHelper
  #根据店铺sid获取店铺网址
  def shop_url(sid)
    "http://shop#{sid}.taobao.com"
  end
  #得到店标url
  def shop_logo_url(logo_path)
    "ttp://logo.taobao.com/shop-logo#{logo_path}"
  end
end
