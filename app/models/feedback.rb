#coding: utf-8
#用户反馈
class Feedback < ActiveRecord::Base
  validates_presence_of :nick,:feedback_message
end
