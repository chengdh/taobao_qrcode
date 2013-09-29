#coding: utf-8
#商品管理界面
class ItemsController < ApplicationController
  include QrCodeService
  after_filter :save_picture_upload_log,only: :picture_upload
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
  end
  #get items/:id/qr_code_img
  #根据传入的参数获取qr_img
  def qr_code_img
    @item = taobao_item_get(params[:id])
    qr_img(@item.detail_url,:jpeg,params)
  end

  #PUT item/:id/img_upload
  #上传商品图片
  def img_upload
    @item = taobao_item_get(params[:id])
    img =  get_qr_img_stream(@item.detail_url,:jpeg,params)
    args = {
      method: 'taobao.item.img.upload',
      session: session_key,
      num_iid: @item.num_iid,
      image: img
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    @item_img = taobao_response.item_img
  end

  #GET items/:id/download_qr
  #下载单个商品的qr_code
  def download_qr
    @item = taobao_item_get(params[:id])
    qr_download(@item.detail_url,@item.title,:jpeg,params)
  end
  #GET items/download_zip
  #将选定的商品二纬码打包成zip再下载
  def download_zip
    @items = params[:ids].collect {|id| taobao_item_get(id)}
    @item_qr_codes = @items.collect do |item|
      qr_options = HashWithIndifferentAccess.new(params[:qr_options][item.num_iid.to_s])
      puts qr_options
      item_img =  get_qr_img(item.detail_url,:jpeg,qr_options)
      [item.num_iid,item_img]
    end
  end
  #PUT item/:id/picture_upload
  #将条码图片上传到淘宝图片空间
  def picture_upload
    @item = taobao_item_get params[:id]
    @item_picture = qr_picture_upload(@item.detail_url,@item.title,:jpeg,params)
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
    taobao_response.item
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
    taobao_response.items
  end
  #商品字段
  def item_fields
    %w[num_iid title nick detail_url type desc cid seller_cids pic_url num price].join(",")
  end
  #每页显示数据条数
  def per_page ; 15; end
  #记录图片上传记录
  def save_picture_upload_log
    ItemPictureUploadLog.create(num_iid: @item.num_iid,nick: taobao_nick,
                                picture_path: @item_picture.picture_path,
                                picture_id: @item_picture.picture_id,
                                title: @item_picture.title)
  end
end
