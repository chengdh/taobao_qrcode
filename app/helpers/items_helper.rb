#coding: utf-8
module ItemsHelper
  def item_qrcode(item)
    text = item.detail_url
    RQRCode::QRCode.new(text, size: 7, level:  :m )
  end
  #获取店铺类目
  def grouped_sellercats
    args = {
      method: "taobao.sellercats.list.get",
      nick:  taobao_nick 
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    origin_seller_cats = taobao_response.seller_cats
    grouped_seller_cats = origin_seller_cats.group_by {|c| c.parent_cid}
    ret = {}
    grouped_seller_cats.each do |k,v|
      ret[origin_seller_cats.detect{|c| c.cid == k}.try(:name)] = v.collect {|cat| [cat.name,cat.cid]} if k > 0
    end
    ret
  end
end
