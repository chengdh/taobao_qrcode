$ ->
  $('.fancybox').fancybox()
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
      $('.btn-update-to-items-img').parent().removeClass('disabled')
    else
      $('.selected-info').html("请选定商品进行操作")
      $('.btn-update-to-items-img').parent().addClass('disabled')
  
  #获取当前界面选定的商品的id数组
  get_selected_item_ids = ->
    selected_items = $('.cbx-select-item:checked:enabled')
    selected_ids = $.map(selected_items,(el) -> $(el).val())
  
  #更新批量下载按钮的href
  update_btn_download_zip_href = ->
    ids = get_selected_item_ids()
    origin_href = $('.btn-download-zip').data('origin-href')
    if ids.length == 0
      $('.btn-download-zip').attr('href',origin_href)
    else
      params = $.param("ids[]" : ids)
      $('.btn-download-zip').attr('href',"#{origin_href}?#{params}")
 
  #上传二维码图片:a 宝贝图片 b 淘宝图片空间
  #param  url_upload items/{:id}/img_upload.js 或
  #       url_upload items/{:id}/picture_upload.js
  upload_img = (upload_url) ->
    selected_items = $('.cbx-select-item:checked:enabled').length
    if selected_items <= 0
      $.notifyBar(
        cssClass: 'error',
        html: '请选择商品进行操作',
        delay: 3000,
        animationSpeed: "normal"
      )  
      return 

    settings = []     
    for id in get_selected_item_ids()
      settings.push(
        data :
          id : id
        type: 'POST'
        dataType : 'script')
  
    hide_loading = ->
      $.unblockUI()
      #$.fancybox.hideLoading()

    ajax_array = []
    ajax_array.push($.ajax(upload_url.replace("{:id}",s.data.id),s)) for s  in  settings

    #$.fancybox.showLoading()
    $.blockUI(message : '处理中...')

    $.when.apply($,ajax_array).then(hide_loading,hide_loading)

  #更新选定的商品条码到taobao服务器上
  $('.btn-update-to-items-img').on('click', ->
    upload_img("items/{:id}/img_upload.js")
  )
  #上传选定的商品二维码图片到淘宝图片空间
  $('.btn-upload-picture').on('click', ->
    upload_img("items/{:id}/picture_upload.js")
  )
  #百度分享相关代码
  #在这里定义bds_config
  bds_config = 'bdText':'扫一扫,淘宝5钻产品大优惠!!!'
  $('#bdshell_js').attr('src',"http://share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000))


