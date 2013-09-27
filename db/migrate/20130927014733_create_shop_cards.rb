#coding: utf-8
#店铺名片记录
class CreateShopCards < ActiveRecord::Migration
  def change
    create_table :shop_cards do |t|
      #店铺id
      t.integer :sid,null: false,limit: 8
      t.string  :nick,null: false,limit: 60
      t.string :title,null: false,limit: 60
      t.string :email,limit: 60
      t.string  :phone,limit: 30
      t.string  :qq,limit: 30
      t.string  :wangwang,limit: 30
      t.string  :weixin,limit: 30
      t.string  :sina_weibo,limit: 30
      t.string  :shop_url,limit: 200
      t.string  :address,limit: 60
      #二维码设置
      t.text :qr_code_img
      t.text :shop_desc

      t.timestamps
    end
    add_index :shop_cards,:sid,unique: true
    add_index :shop_cards,:nick,unique: true
  end
end
