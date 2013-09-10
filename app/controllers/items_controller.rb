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
      fields: item_fields
    }
    args.merge!(params[:search]) if params[:search]
    taobao_response = TaobaoSDK::Session.invoke(args)
    @items = create_paginate_collection(taobao_response,:items,params[:page],per_page)
  end
  #GET items/:id
  def show
    @item = taobao_item_get
    render "show",:layout => false
  end
  #PUT items/:id/update_to_item_describe
  #更新条码到宝贝描述中去
  def update_to_item_describe
    old_item = taobao_item_get
    num_iid = params[:id]
    args = {
      method: 'taobao.item.update',
      session: session_key,
      num_iid: params[:id],
      desc: old_item.desc + render_to_string(:partial => "qr_code",:locals => {:item => old_item},:layout => false)
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    @item = taobao_response.item
  end
  private
  #从taobao平台获取商品信息
  def taobao_item_get
    num_iid = params[:id]
    args = {
      method: 'taobao.item.get',
      session: session_key,
      fields: item_fields,
      num_iid: params[:id]
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    item = taobao_response.item
  end
  def item_fields
    %w[num_iid title nick detail_url type desc cid seller_cids pic_url num price].join(",")
  end
end
