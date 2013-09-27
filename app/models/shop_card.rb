#coding: utf-8
#店铺名片记录
class ShopCard < ActiveRecord::Base
  validates_presence_of :nick,:sid
  validates_uniqueness_of :nick,:sid

  #生成vcard
  def build_vcard
    card = Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
        name.given = self.title
      end
      maker.nickname = self.nick

      maker.add_addr do |addr|
        addr.preferred = true
        addr.location = 'work'
        addr.locality = self.address
        addr.country = 'china'
      end if self.address.present?

      maker.add_tel self.phone if self.phone.present?
      maker.title = self.title if self.title.present?
      maker.add_url self.shop_url if self.shop_url.present?
      maker.add_email self.email if self.email.present?

      maker.add_note self.shop_desc if self.shop_desc.present?
      maker.add_note "QQ:#{self.qq}" if self.qq.present?
      maker.add_note "旺旺:#{self.wangwang}" if self.wangwang.present?
      maker.add_note "微信:#{self.weixin}" if self.weixin.present?
      maker.add_note "新浪微博:#{self.sina_weibo}" if self.sina_weibo.present?
      #添加自定义字段
      #使用andorid手机上的二纬
      maker.add_field Vpim::DirectoryInfo::Field.create('X-QQ', self.qq ) if self.qq.present?
      maker.add_field Vpim::DirectoryInfo::Field.create('X-WANGWANG',self.wangwang) if self.wangwang
      maker.add_field Vpim::DirectoryInfo::Field.create('X-weixin',self.weixin) if self.weixin
      maker.add_field Vpim::DirectoryInfo::Field.create('X-sina_weibo',self.sina_weibo) if self.sina_weibo
    end
    card
  end
end
