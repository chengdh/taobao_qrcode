#coding: utf-8
#商品管理界面
class ItemsController < ApplicationController
  #GET items
  def index
    @items = WillPaginate::Collection.create(1, 5) do |pager|
      args = {
        method: 'taobao.items.onsale.get',
        session: session_key,
        page_size: pager.per_page,
        page_no: pager.current_page,
        fields: 'title,num_iid'
      }
      result = TaobaoSDK::Session.invoke(args)
      # inject the result array into the paginated collection:
      pager.replace(result.items)
      pager.total_entries = result.total_results
    end
  end
end
