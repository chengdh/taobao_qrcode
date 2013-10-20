$ ->
  $('.item-title').ellipsis({maxWidth: 60,maxLine: 2})

  #绑定商品选择事件
  $('.cbx-select-item').on('click',(evt) ->
    el = $(evt.target)
    if el.prop('checked')
      el.parents('.qr-wrapper').find('.qr').addClass('item-selected')
    else
      el.parents('.qr-wrapper').find('.qr').removeClass('item-selected')
    update_selected_info()
    update_btn_download_zip_href()
  )
  #选定全部商品
  $('.cbx-select-item-all').on('click',(evt) ->
    el = $(evt.target)
    if el.prop('checked')
      $('.cbx-select-item').prop('checked',true)
    else
      $('.cbx-select-item').prop('checked',false)
    update_selected_info()
    update_btn_download_zip_href()
  )
  
  #更新商品选择信息
  update_selected_info = ->
    selected_items = $('.cbx-select-item:checked:enabled').length
    if selected_items > 0
      $('.selected-info').html("已选定#{selected_items}个商品")
    else
      $('.selected-info').html("请选定商品进行操作")
  
  #获取当前界面选定的商品的id数组
  get_selected_item_ids = ->
    selected_items = $('.cbx-select-item:checked:enabled')
    selected_ids = $.map(selected_items,(el) -> $(el).val())
  
  #更新批量下载按钮的href
  update_btn_download_zip_href = ->
    ids = get_selected_item_ids()
    origin_href = $('.btn-download-zip').data('origin-href')
    $('.btn-download-zip').attr('href',origin_href)  if ids.length == 0

    selected_items = $('.cbx-select-item:checked:enabled')

    qr_options = new Object()
    for s_item in selected_items
      qr_object = $(s_item).parents('.small-qr').find('.qr-wrapper').data('qr-object')
      id = $(s_item).val()
      qr_options[id] = qr_object

      params = $.param(
        "ids[]" : ids
        qr_options : qr_options
      )
      

      $('.btn-download-zip').attr('href',"#{origin_href}?#{params}")
 
  #上传二维码图片:a 宝贝图片 b 淘宝图片空间
  #param  url_upload items/{:id}/img_upload.js 或
  #       url_upload items/{:id}/picture_upload.js
  upload_img = (upload_url) ->
    selected_items = $('.cbx-select-item:checked:enabled')
    if selected_items.length <= 0
      $.notifyBar(
        cssClass: 'error',
        html: '请选择商品进行操作',
        delay: 3000,
        animationSpeed: "normal"
      )  
      return 

    settings = []     
    for s_item in selected_items
      qr_object = $(s_item).parents('.small-qr').find('.qr-wrapper').data('qr-object')
      settings.push(
        id : $(s_item).val()
        data : qr_object
        type: 'PUT'
        dataType : 'script')
  
    hide_loading = ->
      $.unblockUI()
      $.fancybox.hideLoading()

    ajax_array = []
    ajax_array.push($.ajax(upload_url.replace("{:id}",s.id),s)) for s  in  settings

    $.blockUI(message : '')
    $.fancybox.showLoading()

    $.when.apply($,ajax_array).then(hide_loading,hide_loading)

  #更新选定的商品条码到taobao服务器上
  $('.btn-upload-to-items-img').on('click', ->
    upload_img("items/{:id}/img_upload.js")
  )
  #上传选定的商品二维码图片到淘宝图片空间
  $('.btn-upload-picture').on('click', ->
    upload_img("items/{:id}/picture_upload.js")
  )

  if $('.large-qr').length
    #二维码相关功能:单个商品二维码和店铺url使用了同样的逻辑
    #单个商品二维码
    qr_config = new window.qr_code.QrConfig(    
      width :   $('.large-qr .qr-wrapper').data('width')
      height:   $('.large-qr .qr-wrapper').data('height')
      label :   $('.large-qr .qr-wrapper').data('label')
      logo_url: $('.large-qr .qr-wrapper').data('logo-url')
      is_radius : true
      unit_size : 4)

    qr_config_view = new  window.qr_code.QrConfigView($('.qr-config'),qr_config)
    qr_view = new  window.qr_code.QrView($('.large-qr'),qr_config)
    #绑定上传到宝贝图片按钮事件
    $(qr_config).on('css_change', ->
      css_string = qr_config.to_string()
      qr_object = 
        css : css_string
        qr_width : qr_config.qr_width+20
        qr_height : qr_config.qr_height+20
        logo_url  : qr_config.logo_url
 
      params = $.param(qr_object)
      origin_btn_img_upload_href = $('.btn-img-upload-single').data('origin-href')
      origin_btn_picture_upload_href = $('.btn-picture-upload-single').data('origin-href')
      origin_btn_download_qr_href = $('.btn-download-qr-single').data('origin-href')
      $('.btn-img-upload-single').attr('href',origin_btn_img_upload_href+"?"+params)
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

      set_bdshare('.shop-url-share',new_share_url) if $('.shop-url-share').length
      set_bdshare('.item-share',new_share_url) if $('.item-share').length
    )
    #trigger event
    qr_config.generate_css()

  ## end process .large-qr


  #针对批量上传图片时,只能使用默认样式
  for qr_el in $('.small-qr .qr-wrapper')
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
