class ApplicationController < ActionController::Base
  include TaobaoSDK::Rails::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  acts_as_taobao_controller
  #处理search参数
  #获取店铺信息
  #append_before_filter :get_shop_info
  protected
  #创建will_paginate collection
  def create_paginate_collection(taobao_response,sym_array_method,page = 1,per_page = 5)
    page = 1 if page.blank?
    per_page = 10 if per_page.blank?
    paginate_collection = WillPaginate::Collection.create(page, per_page) do |pager|
      # inject the result array into the paginated collection:
      pager.replace(taobao_response.send(sym_array_method))
      unless pager.total_entries
        # the pager didn't manage to guess the total count, do it manually
        pager.total_entries = taobao_response.total_results
      end
    end
  end
  def get_shop_info
    unless session[:shop].present?
      args = {
        method: 'taobao.shop.get',
        session: session_key,
        nick: session[:taobao_access_token]['taobao_user_nick'],
        fields: 'sid,cid,nick,title,desc,bulletin,pic_path,created,modified,shop_score,remain_count,all_count,used_count'
      }
      resp = TaobaoSDK::Session.invoke(args)
      shop = resp.shop
      session[:shop] = shop
    end
  end
end
