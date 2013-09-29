#coding: utf-8
#首页面板
class DashboardController < ApplicationController
  #GET dashboard/index
  #获取首页信息
  def index
    @shop_card_logs =  ShopCardPictureUploadLog.recent_log(taobao_nick)
    @item_logs = ItemPictureUploadLog.recent_log(taobao_nick)
    @sn_list = get_sn_list
  end
  private
  #获取当前用户社交工具列表
  def get_sn_list
    shop_card = ShopCard.find_by(nick: taobao_nick)
    ret = {}
    ret = {"QQ" => shop_card.try(:qq),
      "phone" => shop_card.try(:phone),
      "wangwang" => shop_card.try(:wangwang),
      "weixin" => shop_card.try(:weixin),
      "sina_weibo" => shop_card.try(:sina_weibo)
    } if shop_card.present?
    ret
  end
end
