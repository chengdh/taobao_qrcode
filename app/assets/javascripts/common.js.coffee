#通用操作
$ ->

  #$('.nav').on('click','li', (evt) -> 
  #  delegate_el = $(evt.delegateTarget)
  #  delegate_el.find('li').removeClass('active')
  #  el = $(evt.target)
  #  el.parent('li').addClass('active')
  #)
  $('[data-toggle="tooltip"]').tooltip()
  $('.colorpicker').simplecolorpicker()
  $(".font-size-slider").noUiSlider(
    range: [12, 20]
    start: 12 
    step : 1
    handles: 1
    connect: "lower"
    slide : -> $(this).trigger('font-size-slide')
  )
  $(".unit-size-slider").noUiSlider(
    range: [4, 8]
    start: 4
    handles: 1
    connect: "lower"
    slide : -> $(this).trigger('unit-size-slide')
  )


  #是否圆角
  $(".radius-slider").noUiSlider(
    range: [0, 1]
    start: 0
    step: 1
    handles: 1
    slide : -> $(this).trigger('radius-slide')
  )
  #是否显示logo
  $(".show-logo-slider").noUiSlider(
    range: [0, 1]
    start: 0
    step: 1
    handles: 1
    slide : -> $(this).trigger('show-logo-slide')
  )



