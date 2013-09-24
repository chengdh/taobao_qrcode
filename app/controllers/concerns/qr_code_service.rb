#coding: utf-8
#提供条码生成服务
module QrCodeService
  extend ActiveSupport::Concern
  #根据传入的文本生成二维码img
  #param: content 二维文本信息
  #option: 二维码显示样式
  # =>css: 二维码的css样式
  # =>qr_width: 二维码宽度
  # =>qr_height: 二维码高度
  # =>logo_url : logo url 地址
  # =>qr_label : label文本
  def get_qr_img(content="",format = :jpeg,qr_options ={})
    qr_html = render_to_string(:partial => "shared/qr",:locals => {:content => content,:logo_url => qr_options[:logo_url],:qr_label => qr_options[:label]},:layout => false)
    qr_img =  generate_qr_img(qr_html,format,qr_options[:css],qr_options[:qr_width],qr_options[:height])
  end
  #生成二维码图片并转换为StringIO
  def get_qr_img_stream(content="",format = :jpeg,qr_options ={})
    qr_img = get_qr_img(content,format,qr_options)
    #NOTE 参考代码https://gist.github.com/Burgestrand/850377
    img_stream = StringIO.new(qr_img)
    def img_stream.path ; "http://localhost:3000/qr_code.jpg" ; end
    img_stream
  end

  private
  #生成商品二维码图像
  def generate_qr_img(qr_html,img_format,css=nil,qr_width = 240,qr_height = 240)
    kit = IMGKit.new(qr_html, :quality => 94,:width => qr_width,:height => qr_height)
    kit.stylesheets << StringIO.new(css) if css.present?
    kit.to_img(img_format) 
  end
end
