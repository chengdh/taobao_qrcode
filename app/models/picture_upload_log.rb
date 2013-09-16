#coding: utf-8
#商品二维码图片上传到淘宝图片空间日志
class PictureUploadLog < ActiveRecord::Base
  validates_presence_of :num_iid,:picture_id,:nick,:picture_path

  #获取给定商品id的最近上传记录
  def self.last_upload_picture(num_iid)
    self.where(:num_iid => num_iid).last
  end
end
