#coding: utf-8
#商品管理界面
class ItemsController < ApplicationController
  #GET items
  def index
    @items = TaobaoSDK::Session.invoke(method: 'taobao.items.onsale.get',session: session_key,fields: 'num_iid')
  end
end
