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
  #PUT item/:id/img_upload
  #上传商品图片
  def img_upload
    @item = taobao_item_get(params[:id])
    html = render_to_string(:partial => "qr_code",:locals => {:item => @item},:layout => false)
    img =  generate_qr_img_stream(html)
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
    qr_html = render_to_string(:partial => "qr_code",:locals => {:item => @item},:layout => false)
    item_img =  generate_qr_img(qr_html)
    send_data item_img,filename: "#{@item.title}.jpg"
  end
  #GET items/download_zip
  #将选定的商品二纬码打包成zip再下载
  def download_zip
    @items = params[:ids].collect {|id| taobao_item_get(id)}
    @item_qr_codes = @items.collect do |item|
      html = render_to_string(:partial => "qr_code",:locals => {:item => item},:layout => false)
      [item.num_iid,generate_qr_img(html)]
    end
  end
  #POST item/:id/picture_upload
  #将条码图片上传到淘宝图片空间
  def picture_upload
    @item = taobao_item_get params[:id]
    html = render_to_string(:partial => "qr_code",:locals => {:item => @item},:layout => false)
    img =  generate_qr_img_stream(html)
    args = {
      method: 'taobao.picture.upload',
      session: session_key,
      picture_category_id: 0,
      image: img,
      image_input_title: "#{@item.title}.jpg"
      }
      taobao_response = TaobaoSDK::Session.invoke(args)
      @item_picture = taobao_response.picture
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
  def generate_qr_img_stream(qr_html)
    img = generate_qr_img(qr_html)
    #NOTE 参考代码https://gist.github.com/Burgestrand/850377
    img_stream = StringIO.new(img)
    def img_stream.path ; "http://localhost/qr_img.jpg" ; end
    img_stream
  end
  #生成商品二维码图像
  def generate_qr_img(qr_html)
      kit = IMGKit.new(qr_html, 
                        :quality => 94,
                        :height => 240,
                        :width => 240
                      )
      kit.stylesheets << StringIO.new(
<<CSS
  .qr-wrapper{
    position : relative;
  }
  img.item-img{
    cursor : pointer;
    position: absolute;
    top: 50%;
    left: 50%;
    width: 40px;
    height: 40px;
    margin-top: -20px; /* Half the height */
    margin-left: -20px; /* Half the width */
  }
  table.item-qr-code{
    cursor : pointer;
    border-width: 0;
    border-style: none;
    border-color: #0000ff;
    border-collapse: collapse;
    width : 240px;
    height : 240px;
  }
  table.item-qr-code td.black{
    border-width: 0; 
    border-style: none;
    border-color: #0000ff; 
    border-collapse: collapse; 
    padding: 0; 
    margin: 0; 
    width: 4px; 
    height: 4px; 
    background : #000;
  }
  table.item-qr-code td.white{
    border-width: 0; 
    border-style: none;
    border-color: #0000ff; 
    border-collapse: collapse; 
    padding: 0; 
    margin: 0; 
    width: 4px; 
    height: 4px; 
    background : #fff;
  }
CSS
      )
      kit.to_img(:jpeg) 
  end
  #每页显示数据条数
  def per_page ; 15; end
end
