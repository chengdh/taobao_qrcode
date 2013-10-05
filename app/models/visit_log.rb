#coding: utf-8
#查看记录
class VisitLog < ActiveRecord::Base
  validates_presence_of :nick,:controller,:action
end
