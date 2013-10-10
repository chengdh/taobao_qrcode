# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if $('.shop-card-qr').length
    #店铺名片二维码
    shop_card_qr_config = new window.qr_code.QrConfig(    
      width :   $('.shop-card-qr .qr-wrapper').data('width')
      height:   $('.shop-card-qr .qr-wrapper').data('height')
      label :   $('.shop-card-qr .qr-wrapper').data('label')
      logo_url: $('.ship-card-qr .qr-wrapper').data('logo-url')
      is_radius : true
      unit_size : 4)
    shop_card_qr_config_view = new  window.qr_code.QrConfigView($('.qr-config'),shop_card_qr_config)
    shop_card_qr_view = new  window.qr_code.QrView($('.shop-card-qr'),shop_card_qr_config)
 
    #店铺名片二维码样式调整时,需要更新对应的按钮
    $(shop_card_qr_config).on('css_change', ->
      css_string = shop_card_qr_config.to_string()
      qr_object = 
        css : css_string
        qr_width : shop_card_qr_config.qr_width+20
        qr_height : shop_card_qr_config.qr_height+20
        logo_url  : shop_card_qr_config.logo_url
 
      params = $.param(qr_object)
      origin_btn_picture_upload_href = $('.btn-picture-upload-single').data('origin-href')
      origin_btn_download_qr_href = $('.btn-download-qr-single').data('origin-href')
      $('.btn-picture-upload-single').attr('href',origin_btn_picture_upload_href+"?"+params)
      $('.btn-download-qr-single').attr('href',origin_btn_download_qr_href+"?"+params)
      #复制二维码地址
      origin_qr_code_img_url = $('#qr_code_img_url').data('origin-url')
      new_share_url = origin_qr_code_img_url+"&"+params
      $('#qr_code_img_url').html(new_share_url)

      #百度分享链接
      set_bdshare = (el_class,share_url)-> 
        bdshare_data = $.parseJSON($(el_class).attr('data'))
        bdshare_data.pic = share_url
        bdshare_data.url = share_url
        $(el_class).attr('data',JSON.stringify(bdshare_data))

      set_bdshare('.shop-card-share',new_share_url) if $('.shop-card-share').length
    )
    #trigger event
    shop_card_qr_config.generate_css()
    #生成店铺名片二维码
    $('.btn-generate-shop-vcard').on('click', -> 
      $('.shop-card-qr').block(message : "正在生成...")
      $('.vcard-form').submit()
    )
    $('.shop-card-qr').on('refresh',->  shop_card_qr_config.generate_css())

  # end process .shop-card-qr
