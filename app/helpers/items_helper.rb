#coding: utf-8
module ItemsHelper
  def item_qrcode(item)
    RQRCode::QRCode.new(item.title, size: 4, level:  :h )
  end
end
