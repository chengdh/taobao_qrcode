#coding: utf-8
module ItemsHelper
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
      #判断是否有二级分类,如果有二级分类,需要删除parent_cid = 0的分类
      if origin_seller_cats.detect {|c| c.parent_cid > 0}.present?
        ret[origin_seller_cats.detect{|c| c.cid == k}.try(:name)] = v.collect {|cat| [cat.name,cat.cid]} if k > 0
      else
        ret[origin_seller_cats.detect{|c| c.cid == k}.try(:name)] = v.collect {|cat| [cat.name,cat.cid]}
      end
    end
    ret
  end
end
