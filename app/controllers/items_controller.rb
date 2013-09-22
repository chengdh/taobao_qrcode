#coding: utf-8
#商品管理界面
class ItemsController < ApplicationController
  before_filter :auto_taobao_picture_upload,only: :show
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
    @picture = PictureUploadLog.last_upload_picture(params[:id])
  end

  #PUT item/:id/img_upload
  #上传商品图片
  def img_upload
    @item = taobao_item_get(params[:id])
    html = render_to_string(:partial => "shared/qr",:locals => {:item => @item,:logo_url => params[:logo_url]},:layout => false)
    img =  generate_qr_img_stream(html,params[:css],params[:qr_width],params[:qr_height])
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
    qr_html = render_to_string(:partial => "shared/qr",:locals => {:item => @item,:logo_url => params[:logo_url]},:layout => false)
    item_img =  generate_qr_img(qr_html,params[:css],params[:qr_width],params[:height])
    send_data item_img,filename: "#{@item.title}.jpg"
  end
  #GET items/download_zip
  #将选定的商品二纬码打包成zip再下载
  def download_zip
    @items = params[:ids].collect {|id| taobao_item_get(id)}
    @item_qr_codes = @items.collect do |item|
      html = render_to_string(:partial => "shared/qr",:locals => {:item => item},:layout => false)
      [item.num_iid,generate_qr_img(html)]
    end
  end
  #PUT item/:id/picture_upload
  #将条码图片上传到淘宝图片空间
  def picture_upload
    @item,@item_picture = taobao_picture_upload params[:id]
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
  #商品字段
  def item_fields
    %w[num_iid title nick detail_url type desc cid seller_cids pic_url num price].join(",")
  end

  #生成二维码图片并转换为StringIO
  def generate_qr_img_stream(qr_html,css=nil,qr_width = 240,qr_height = 240)
    img = generate_qr_img(qr_html,css,qr_width,qr_height)
    #NOTE 参考代码https://gist.github.com/Burgestrand/850377
    img_stream = StringIO.new(img)
    def img_stream.path ; "http://localhost/qr_img.jpg" ; end
    img_stream
  end
  #生成商品二维码图像
  def generate_qr_img(qr_html,css=nil,qr_width = 240,qr_height = 240)
    kit = IMGKit.new(qr_html, :quality => 94,:width => qr_width,:height => qr_height)
    kit.stylesheets << StringIO.new(css) if css.present?
    kit.to_img(:jpeg) 
  end
  #上传商品二维码到淘宝图片空间
  def taobao_picture_upload(num_iid)
    item = taobao_item_get num_iid
    html = render_to_string(:partial => "shared/qr",:locals => {:item => item,:logo_url => params[:logo_url]},:layout => false)
    img =  generate_qr_img_stream(html,params[:css],params[:qr_width],params[:qr_height])
    args = {
      method: 'taobao.picture.upload',
      session: session_key,
      picture_category_id: 0,
      image: img,
      image_input_title: "#{item.title}.jpg"
      }
    taobao_response = TaobaoSDK::Session.invoke(args)
    item_picture = taobao_response.picture
    return item,item_picture
  end
  #显示宝贝详细界面时,自动将二维码上传到淘宝图片空间
  def auto_taobao_picture_upload
    p_upload_log = PictureUploadLog.last_upload_picture(params[:id])
    if p_upload_log.blank?
      item,picture = taobao_picture_upload(params[:id]) 

      nick = session[:taobao_access_token]['taobao_user_nick']
      PictureUploadLog.create(nick: nick, 
                              num_iid: params[:id].to_i,
                              picture_id: picture.picture_id,
                              picture_path: picture.picture_path)
    end
  end
  #每页显示数据条数
  def per_page ; 15; end
end
