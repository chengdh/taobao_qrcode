#coding: utf-8
class Logo < ActiveRecord::Base
  has_attached_file :img, :styles => { :medium => "300x300>", :thumb => "50x50" }, :default_url => "/images/:style/missing.png"
end
