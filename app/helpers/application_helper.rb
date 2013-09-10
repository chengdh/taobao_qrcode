#coding: utf-8
module ApplicationHelper
  def taobao_nick
    session[:taobao_access_token]['taobao_user_nick']
  end
end
