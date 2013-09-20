#coding: utf-8
#用户上传logo
class CreateLogos < ActiveRecord::Migration
  def up
    create_table :logos do |t|
      t.string :nick,:limit => 60,:null => false

      t.timestamps
    end
    add_index :logos,:nick
    add_attachment :logos, :img
  end
  def down
    remove_table :logos
  end
end
