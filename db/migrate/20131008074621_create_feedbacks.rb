#coding: utf-8
#创建feedback
class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :nick,null: false,limit: 60
      t.string :feedback_name,limit: 60
      t.text :feedback_message,null: false

      t.timestamps
    end
    add_index :feedbacks,:nick
  end
end
