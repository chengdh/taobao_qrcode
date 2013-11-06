#turbolinks spinner
#参考http://stackoverflow.com/questions/14045428/zeroclipboard-not-working-in-a-rails-app-flash-bridge-error-works-locally-of
#ZeroClipboard在使用turbolinks需要先销毁

#$(document).on("page:before-change", ->
#  ZeroClipboard.destroy()
#)
#$(document).on('page:fetch', -> 
#  $.blockUI(message : "")
#  $.fancybox.showLoading()
#)
#$(document).on('page:change', -> 
#  $.unblockUI()
#  $.fancybox.hideLoading()
#)
#通用操作
$ ->
  #ZeroClipboard.destroy()
  clip = new ZeroClipboard($("#btn_clip"))
  clip.on('complete', -> $('.clip-success').show())


  $('.fancybox').fancybox()
  #feeback buton
  fm_options = 
        position : "right-top"
        show_email : false
        message_required : true
        name_required : false
        show_asterisk_for_required : true
        feedback_url : "/feedbacks.js"
        title_label : ""
        name_label : ""
        email_label : ""
        message_label : ""
        trigger_label : "问题建议"
        name_placeholder : "尊姓大名"
        email_placeholder : "a@b.com"
        message_placeholder: "填写您的宝贵意见,便于我们改进软件"
        submit_label: "确认发送"
        close_on_click_outisde: true	

  #fm.init(fm_options)
  $('.front-colorpicker').simplecolorpicker()
  $('.back-colorpicker').simplecolorpicker()
  $('.front-colorpicker').simplecolorpicker()
  $(".font-size-slider").noUiSlider(
    range: [12, 20]
    start: 12 
    step : 1
    handles: 1
    connect: "lower"
    slide : -> $('.font-size-badge').html($(this).val())
  ).change(-> $(this).trigger('unit-size-slide'))

  $(".unit-size-slider").noUiSlider(
    range: [4, 15]
    start: 4
    step: 1
    handles: 1
    connect: "lower"
    slide : -> $('.unit-size-badge').html($(this).val())
  ).change(-> $(this).trigger('unit-size-slide'))


  #是否圆角
  $(".radius-slider").noUiSlider(
    range: [0, 1]
    start: 0
    step: 1
    handles: 1
  ).change( -> $(this).trigger('radius-slide'))
  #是否显示logo
  $(".show-logo-slider").noUiSlider(
    range: [0, 1]
    start: 0
    step: 1
    handles: 1
  ).change( -> $(this).trigger('show-logo-slide'))
