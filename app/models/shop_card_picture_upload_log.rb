#coding: utf-8
#店铺名片二维码上传记录
class ShopCardPictureUploadLog < PictureUploadLog
  validates_presence_of :sid,:picture_id,:nick,:picture_path
end
