#coding: utf-8
require 'spec_helper'

describe ShopsController do
  render_views
  let_valid_session

  let(:shop_get_response) {FactoryGirl.build(:shop_get_response)}
  #获取当前店铺信息
  describe "GET current" do
    it "get shop info by nick and assigns shop as @shop" do
      TaobaoSDK::Session.should_receive(:invoke).and_return(shop_get_response)
      shop = shop_get_response.shop
      get :current,{},valid_session
      assigns(:shop).should eq(shop)
    end
  end
  #更新店铺二维码到淘宝图片空间
  describe "PUT current_qr_upload" do
    it "should success" do
      shop = FactoryGirl.build(:shop)
      controller.should_receive(:current_shop_get).and_return(shop)
      TaobaoSDK::Session.should_receive(:invoke).and_return(FactoryGirl.build(:picture_upload_response))
      put :current_qr_upload,{},valid_session
      response.should be_success
    end
  end
  #下载店铺二维码
  describe "GET current_download_qr" do
    it "should success" do
      shop = FactoryGirl.build(:shop)
      controller.should_receive(:current_shop_get).and_return(shop)
      get :current_download_qr,{},valid_session
      response.should be_success
    end
  end
  #GET shops/current_qr_code_img
  #获取店铺二维码图片
  describe "GET shops/current_qr_code_img" do
    it "should success" do
      shop = FactoryGirl.build(:shop)
      controller.should_receive(:current_shop_get).and_return(shop)
      get :current_qr_code_img,{},valid_session
      response.should be_success
    end
  end
end
