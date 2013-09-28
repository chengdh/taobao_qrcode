#coding: utf-8
#给picture_upload_logs添加相关字段
class AddTypeToPictureUploadLog < ActiveRecord::Migration
  def change
    add_column :picture_upload_logs,:type,:string,:null => false,:limit => 60  #类型
    add_column :picture_upload_logs,:sid,:integer,:limit => 8
  end
end
