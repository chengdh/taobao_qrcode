#coding: utf-8
#修改num_iid可为空
class ChangeNumIid < ActiveRecord::Migration
  def change
    add_column :picture_upload_logs,:title,:string,:limit => 60  #图片标题
    change_column :picture_upload_logs,:num_iid,:integer,:null => true,:limit => 8
  end
end
