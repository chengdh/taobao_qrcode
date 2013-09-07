#coding: utf-8
#商品管理界面
class ItemsController < ApplicationController
  #GET items
  def index
    per_page =  20
    args = {
      method: 'taobao.items.onsale.get',
      session: session_key,
      page_size: per_page,
      page_no: params[:page],
      fields: 'title,num_iid'
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    @items = create_paginate_collection(taobao_response,:items,params[:page],per_page)
  end
end
