#coding: utf-8
#商品管理界面
class ItemsController < ApplicationController
  #GET items
  def index
    args = {
      method: 'taobao.items.onsale.get',
      session: session_key,
      page_size: per_page,
      page_no: params[:page],
      fields: item_fields
    }
    args.merge!(params[:search]) if params[:search]
    taobao_response = TaobaoSDK::Session.invoke(args)
    num_iids= taobao_response.items.collect {|item| item.num_iid}
    items = taobao_items_list_get(num_iids)
    @items = create_paginate_collection(taobao_response,items,params[:page],per_page)
  end
  #GET items/:id
  def show
    @item = taobao_item_get(params[:id])
    render "show",:layout => false
  end
  #PUT items/update_to_item_describe
  #params[:ids] 需要更新的商品num_iid
  #更新条码到宝贝描述中去
  def update_to_items_describe 
    @items = []
    items = params[:ids].collect {|id| taobao_item_get(id)}
    items.each do |old_item|
      args = {
        method: 'taobao.item.update',
        session: session_key,
        num_iid: old_item.num_iid,
        #desc: old_item.desc + render_to_string(:partial => "qr_code",:locals => {:item => old_item},:layout => false)
        #NOTE 商品描述好像不能以html字符开头
        desc: "this is a test #{render_to_string(:partial => "qr_code",:locals => {:item => old_item},:layout => false)}"
      }
      taobao_response = TaobaoSDK::Session.invoke(args)
      item = taobao_response.item
      @items.push(item)
    end
    @items
  end
  #PUT items/:id/item_img_upload
  #上传商品图片
  def img_upload
    @item_images = []
    @items = params[:ids].collect {|id| taobao_item_get(id)}
    @items.each do |old_item|
      html = render_to_string(:partial => "qr_code",:locals => {:item => old_item},:layout => false)
      kit = IMGKit.new(html, :quality => 50)
      kit.stylesheets << StringIO.new(
<<CSS
        img.item-img{
          position : relative;
          cursor : pointer;
          left : 40px;
          top : 40px;
          width : 30px;
          height : 30px;
        }
        table.item-qr-code{
          border : none;
          border-collapse : collapse;
          margin : 0;
          padding : 0;
          cursor : pointer;
        }
        table.item-qr-code td.black{
          border : none;
          height : 4px;
          width : 8px;
          background : #000;
        }
        table.item-qr-code td.white{
          border : none;
          height : 4px;
          width : 4px;
          background : #fff;
        }
CSS
      )
      #NOTE 参考代码https://gist.github.com/Burgestrand/850377
      img = StringIO.new(kit.to_img(:jpeg))
      def img.path ; "http://localhost/img.png" ; end
      args = {
        method: 'taobao.item.img.upload',
        session: session_key,
        num_iid: old_item.num_iid,
        image: img
      }
      taobao_response = TaobaoSDK::Session.invoke(args)
      @item_images.push(taobao_response.item_img)
    end
  end

  private
  #从taobao平台获取商品信息
  def taobao_item_get(num_iid)
    args = {
      method: 'taobao.item.get',
      session: session_key,
      fields: item_fields,
      num_iid: num_iid
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    item = taobao_response.item
  end
  #根据num_iids批量返回商品详细信息
  def taobao_items_list_get(num_iids)
    args = {
      method: 'taobao.items.list.get',
      session: session_key,
      fields: item_fields,
      num_iids: num_iids.join(",")
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    items = taobao_response.items
  end
  def item_fields
    %w[num_iid title nick detail_url type desc cid seller_cids pic_url num price].join(",")
  end
  #每页显示数据条数
  def per_page ; 5; end
end
