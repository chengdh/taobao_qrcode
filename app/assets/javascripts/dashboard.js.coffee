# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #dashboard sn_list 社交工具二维码
  for qr_el in $('.sn-qr .qr-wrapper')
    options = 
      width :   $(qr_el).data('width')
      height:   $(qr_el).data('height')
      logo_url: $(qr_el).data('logo-url')
      label:    ""
      unit_size : 2

    qr_config = new  window.qr_code.QrConfig(options)
    qr_view = new  window.qr_code.QrView($(qr_el),qr_config)
    qr_config.generate_css()
    qr_object = 
      css : qr_config.to_string()
      qr_width : qr_config.qr_width + 20
      qr_height : qr_config.qr_height + 20
      logo_url: qr_config.logo_url

    $(qr_el).data('qr-object',qr_object)
