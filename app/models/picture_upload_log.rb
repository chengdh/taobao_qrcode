#coding: utf-8
#二维码图片上传到淘宝图片空间日志
class PictureUploadLog < ActiveRecord::Base
  #最近上传的图片日志
  scope :recent_log,lambda{|nick| where(nick: nick).order('created_at DESC').limit(6)}
  #是否还未上传过图片
  def self.init?(nick)
    self.where(nick: nick).exists?
  end
end
