#coding: utf-8
#首页面板
class DashboardController < ApplicationController
  #设置多说的cookie
  before_filter :set_duoshuo_cookie,only: :index
  #GET dashboard/index
  #获取首页信息
  def index
    @shop_card_logs =  ShopCardPictureUploadLog.recent_log(taobao_nick)
    @item_logs = ItemPictureUploadLog.recent_log(taobao_nick)
    @sn_list = get_sn_list
  end
  #GET dashboard/faq
  def faq;end
  private
  #获取当前用户社交工具列表
  def get_sn_list
    shop_card = ShopCard.find_by(nick: taobao_nick)
    ret = {}
    ret = {"qq" => shop_card.try(:qq),
      "phone" => shop_card.try(:phone),
      "wangwang" => shop_card.try(:wangwang),
      "weixin" => shop_card.try(:weixin),
      "sina_weibo" => shop_card.try(:sina_weibo)
    } if shop_card.present?
    ret
  end
  def set_duoshuo_cookie
    short_name = Settings[:duoshuo][:short_name]
    secret = Settings[:duoshuo][:secret]
    token = {short_name: short_name, user_key: taobao_nick, name: taobao_nick}
    duoshuo_token = JWT.encode(token, secret)
    cookies[:duoshuo_token] = duoshuo_token
  end
end
