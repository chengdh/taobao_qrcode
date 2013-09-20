json.files do
  json.array!([@logo]) do |logo|
    json.name   logo.img_file_name
    json.size   logo.img_file_size
    json.url    logo.img.url
    json.thumbnail_url logo.img.url(:thumb)
    json.delete_url logo_path(:id => logo)
    json.delete_type "DELETE"
  end
end
