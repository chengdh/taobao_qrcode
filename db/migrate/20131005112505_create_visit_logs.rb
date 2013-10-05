#coding: utf-8
#记录访问日志
class CreateVisitLogs < ActiveRecord::Migration
  def change
    create_table :visit_logs do |t|
      t.string :nick,null: false,limit: 60
      t.string :controller,null: false,limit: 60
      t.string :action,null: false,limit: 60

      t.timestamps
    end
    add_index :visit_logs,:nick
    add_index :visit_logs,:controller
    add_index :visit_logs,:action
  end
end
