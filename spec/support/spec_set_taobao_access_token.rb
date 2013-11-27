#coding: utf-8
#测试时,设置taobao_access_token
module  Taobao
  TAOBAO_TOKEN = HashWithIndifferentAccess.new({"w2_expires_in" => 1800, 
            "taobao_user_id" => "3600300860", 
            "taobao_user_nick" => "sandbox_cdh", 
            "w1_expires_in" => 12960000, 
            "re_expires_in" => 15552000, 
            "r2_expires_in" => 259200, 
            "expires_in" => 12960000, 
            "token_type" => "Bearer", 
            "refresh_token" => "620110248bdf55ac8ce3d3ef0ed539eeb671584376824683600300860", 
            "access_token" => "6202202fb9ZZ5c14fd720000853757717f856a651ea46463600300860", 
            "r1_expires_in" => 12960000})

  def set_taobao_access_token
    session[:taobao_access_token] = TAOBAO_TOKEN
  end
  def let_valid_session
    let(:valid_session) { session[:taobao_access_token] = TAOBAO_TOKEN }
  end
end
