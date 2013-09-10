#coding: utf-8
module ItemsHelper
  def item_qrcode(item)
    RQRCode::QRCode.new(item.title, size: 4, level:  :h )
  end
  #获取店铺类目
  def sellercats_for_select
    args = {
      method: "taobao.sellercats.list.get",
      nick:  taobao_nick 
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    taobao_response.seller_cats
  end
end
