#coding: utf-8
module ApplicationHelper
  #获取当前淘宝登录用户名
  def taobao_nick
    session[:taobao_access_token]['taobao_user_nick']
  end
end
