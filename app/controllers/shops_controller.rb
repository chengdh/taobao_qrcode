#coding: utf-8
#店铺管理
class ShopsController < ApplicationController
  include QrCodeService
  include ShopsHelper
  #GET shops/current
  def current
    @shop = current_shop_get
    render action: :show
  end
  #PUT shops/current_qr_upload
  #上传店铺网址二维码到淘宝图片空间
  def current_qr_upload
    @shop = current_shop_get
    img =  get_qr_img_stream(shop_url(@shop.sid),:jpeg,params)
    args = {
      method: 'taobao.picture.upload',
      session: session_key,
      picture_category_id: 0,
      image: img,
      image_input_title: "#{@shop.title}.jpg"
      }
    taobao_response = TaobaoSDK::Session.invoke(args)
    @picture = taobao_response.picture
  end
  #GET shops/current_download_qr
  #下载店铺的qr_code
  def current_download_qr
    @shop = current_shop_get
    shop_img =  get_qr_img(shop_url(@shop.sid),:jpeg,params)
    send_data shop_img,filename: "#{@shop.title}.jpg"
  end
  #get shops/current_qr_code_img
  #根据传入的参数获取qr_img
  def current_qr_code_img
    @shop = current_shop_get
    qr_img = get_qr_img(shop_url(@shop.sid),:jpeg,params)
    send_data qr_img,type: :jpeg,disposition: :inline
  end


  private
  def shop_fields
    %w[sid cid title nick desc bulletin pic_path created modified].join(",")
  end
  def current_shop_get
    args = {
      method: 'taobao.shop.get',
      session: session_key,
      fields: shop_fields,
      nick:  taobao_nick
    }
    taobao_response = TaobaoSDK::Session.invoke(args)
    taobao_response.shop
  end
end
