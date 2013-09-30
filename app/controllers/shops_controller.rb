#coding: utf-8
#店铺管理
class ShopsController < ApplicationController
  include QrCodeService
  include ShopsHelper
  after_filter :save_shop_picture_upload_log,only: :current_qr_upload
  after_filter :save_shop_card_picture_upload_log,only: :current_card_qr_upload
  #GET shops/current
  def current
    @shop = current_shop_get
    render action: :show
  end
  #GET shops/current_card
  def current_card
    @shop = current_shop_get
    #获取shop card 信息
    @shop_card = ShopCard.find_by_sid(@shop.sid)
    @shop_card ||= ShopCard.new(nick: @shop.nick,sid: @shop.sid,
                                title: @shop.nick,shop_url: shop_url(@shop.sid),
                                shop_desc: @shop.desc
                               )
  end
  #PUT shops/current_qr_upload
  #上传店铺网址二维码到淘宝图片空间
  def current_qr_upload
    @shop = current_shop_get
    @picture = qr_picture_upload(shop_url(@shop_sid),@shop.title,:jpeg,params)
  end
  #GET shops/current_download_qr
  #下载店铺的qr_code
  def current_download_qr
    @shop = current_shop_get
    qr_download(shop_url(@shop_sid),@shop.title,:jpeg,params)
  end
  #get shops/current_qr_code_img
  #根据传入的参数获取qr_img
  def current_qr_code_img
    @shop = current_shop_get
    qr_img(shop_url(@shop_sid),:jpeg,params)
  end

  ############店铺名片相关action#########################
  #PUT shops/generate_card
  #生成店铺名片二维码
  def generate_card
    @shop = current_shop_get
    @shop_card = ShopCard.find_or_create_by(nick: @shop.nick,sid: @shop.sid,title: @shop.title)
    @shop_card.update_attributes(shop_card_params)
  end

  #PUT shops/current_qr_upload
  #上传店铺网址二维码到淘宝图片空间
  def current_card_qr_upload
    @shop = current_shop_get
    @shop_card = ShopCard.find_by_sid(@shop.sid)
    @picture = qr_picture_upload(@shop_card.build_vcard.to_s,@shop.title,:jpeg,params)
  end
  #GET shops/current_download_qr
  #下载店铺的qr_code
  def current_card_download_qr
    @shop = current_shop_get
    @shop_card = ShopCard.find_by_sid(@shop.sid)
    qr_download(@shop_card.build_vcard.to_s,@shop.title,:jpeg,params)
  end
  #get shops/current_qr_code_img
  #根据传入的参数获取qr_img
  def current_card_qr_code_img
    @shop = current_shop_get
    @shop_card = ShopCard.find_by_sid(@shop.sid)
    qr_img(@shop_card.build_vcard.to_s,:jpeg,params)
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
    # Never trust parameters from the scary internet, only allow the white list through.
  def shop_card_params
    params.require(:shop_card).permit!
  end
  #记录图片上传记录
  def save_shop_picture_upload_log
    ShopPictureUploadLog.create(sid: @shop.sid,nick: taobao_nick,
                                picture_path: @picture.picture_path,
                                picture_id: @picture.picture_id,
                                title: @picture.title)
  end
  def save_shop_card_picture_upload_log
    ShopCardPictureUploadLog.create(sid: @shop.sid,nick: taobao_nick,
                                picture_path: @picture.picture_path,
                                picture_id: @picture.picture_id,
                                title: @picture.title)
  end

end
