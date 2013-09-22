#coding: utf-8
require 'spec_helper'

describe Logo do
  it "should save logo model success" do
    logo = FactoryGirl.build(:logo)
    logo.save!
  end
end
