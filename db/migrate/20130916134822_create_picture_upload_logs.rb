#coding: utf-8
#二维码图片上传记录
class CreatePictureUploadLogs < ActiveRecord::Migration
  def change
=begin
:limit	Numeric Type	Column Size	Max value
1	tinyint	1 byte	127
2	smallint	2 bytes	32767
3	mediumint	3 byte	8388607
nil, 4, 11	int(11)	4 byte	2147483647
5..8	bigint	8 byte	9223372036854775807
Note: by default MySQL uses signed integers and Rails has no way (that I know of) to change this behaviour. Subsequently, the max. values noted are for signed integers.
=end
    create_table :picture_upload_logs do |t|
      t.string :nick,limit: 60,null: false
      t.integer :num_iid,null: false,limit: 8
      t.integer :picture_id,null: false,limit: 8
      t.string :picture_path,null: false,limit: 300

      t.timestamps
    end
    add_index :picture_upload_logs,:nick
    add_index :picture_upload_logs,:num_iid
    add_index :picture_upload_logs,:picture_id
  end
end
