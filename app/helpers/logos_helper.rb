module LogosHelper
  #获取paperclip的绝对url
  def absolute_logo_url(logo,attachment_style = :original)
    "#{request.protocol}#{request.host_with_port}#{logo.img.url(attachment_style)}"
  end
end

