#coding: utf-8
require 'spec_helper'

describe Feedback do
  it "应能正确保存feedback" do
    feedback = FactoryGirl.build(:feedback)
    feedback.save!
  end
end
