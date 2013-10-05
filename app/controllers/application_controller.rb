class ApplicationController < ActionController::Base
  include TaobaoSDK::Rails::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  acts_as_taobao_controller
  #保存访问记录
  after_filter :save_visit_log
  protected
  #创建will_paginate collection
  def create_paginate_collection(taobao_response,objects_or_sym_method,page = 1,per_page = 5)
    page = 1 if page.blank?
    per_page = 10 if per_page.blank?
    WillPaginate::Collection.create(page, per_page) do |pager|
      # inject the result array into the paginated collection:
      pager.replace(taobao_response.send(objects_or_sym_method)) if objects_or_sym_method.is_a? Symbol
      pager.replace(objects_or_sym_method) if objects_or_sym_method.is_a? Array

      unless pager.total_entries
        # the pager didn't manage to guess the total count, do it manually
        pager.total_entries = taobao_response.total_results
      end
    end
  end
  def taobao_nick
    session[:taobao_access_token]['taobao_user_nick']
  end
  def save_visit_log
    nick = taobao_nick
    vl =  VisitLog.find_or_create_by(nick: nick,controller: params[:controller],action: params[:action]) if nick.present?
    vl.touch
  end
end
