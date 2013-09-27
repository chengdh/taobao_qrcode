#coding: utf-8
module ApplicationHelper
  #获取当前淘宝登录用户名
  def taobao_nick
    session[:taobao_access_token]['taobao_user_nick']
  end

  #NOTE 不再使用
  def get_data_uri(image_url)
    require 'open-uri'
    img_type = image_url.split('.')[-1]
    img_type = image_url.split('?')[0]
    img_binary = open(image_url).read
    img_data = ::Base64.encode64(img_binary).gsub("\n", '')
    "data:image/#{img_type};base64,#{img_data}"
  end
  def qrcode(content,size = 14,level = :m)
    RQRCode::QRCode.new(content, size: size, level:  level )
  end

end
