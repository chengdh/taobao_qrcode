#coding: utf-8
module ApplicationHelper
  #获取当前淘宝登录用户名
  def taobao_nick
    session[:taobao_access_token]['taobao_user_nick']
  end

  #<b>DEPRECATED:</b> 
  def get_data_uri(image_url)
    require 'open-uri'
    img_type = image_url.split('.')[-1]
    img_type = image_url.split('?')[0]
    img_binary = open(image_url).read
    img_data = ::Base64.encode64(img_binary).gsub("\n", '')
    "data:image/#{img_type};base64,#{img_data}"
  end
  def qrcode(content)
    #RQRCode::QRCode.new(content, size: size, level:  level )
    qr = RQRCode::QRCode.new(content)
    qr = RQRCode::QRCode.new(content,size: 14) if qr.version < 14
    qr
  end
  #判断是否第一次进入action
  def first_visit?
    ret = false
    nick = taobao_nick
    ret = VisitLog.exists?(nick: nick,controller: params[:controller],action: params[:action]) if nick.present?
    not ret
  end
  #设置nav tab的active
  def  set_nav_active(cur_controller_name)
    ""
    "active" if cur_controller_name.eql?(controller_name)
  end
end
