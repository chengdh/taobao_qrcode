#coding: utf-8
#店铺url二维码上传记录
class ShopPictureUploadLog < PictureUploadLog
  validates_presence_of :sid,:picture_id,:nick,:picture_path
end
