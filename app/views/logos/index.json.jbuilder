#给jquery-file-upload返回的格式如下
#{
#  files : []
#  length : 10
#}
json.files do
  json.array!(@logos) do |logo|
    json.name   logo.img_file_name
    json.size   logo.img_file_size
    json.url    logo.img.url
    json.thumbnail_url logo.img.url(:thumb)
    json.delete_url logo_path(:id => logo)
    json.delete_type "DELETE"
  end
end
json.length @logos.size
