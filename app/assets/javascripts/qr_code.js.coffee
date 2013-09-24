#定义与qr_code相关的类
#
#二维码设置类
$ ->
  class QrConfig
    constructor: (options)->
      #options object 二维码初始化参数
      #width 宽度
      #height 高度
      #其他与实例变量相同
      #------------------------------------------------------
      @unit_size = 4          #单个点的大小,以px为单位
      @is_radius = false      #是否圆角
      @b_color = '#FFFFFF'    #背景色
      @f_color = '#000000'    #前景色
  
      @label =  ""            #文字信息
      @font_size = 12         #字体大小
      @font_color = "#000000" #字体颜色
  
      @show_logo = true       #是否显示logo
      @logo_url = ""          #图标url
      @logo_width = 40
      @logo_height = 40
      @logo_left = 0          #图标左方位坐标
      @logo_top = 0           #上方位坐标

      #根据传入的options覆盖默认值
      for attr of options
        this[attr] = options[attr]

      @qr_width = @unit_size*@width
      @qr_height = @unit_size*@height
  
  
      #默认的css样式
      @css = 
        "qr-logo" :
          position  : "absolute"
          left      : 0
          top       : 0
          width     : '40px'
          height    : '40px'
        "qr-table" :
          border : 'none'
          'border-collapse' : 'collapse'
        "qr-td" :
          'border-style'  : 'none'
          'border-color'  : '#0000FF'
          'padding'       : 0
          'margin'        : 0
          'border-collapse': 'collapse'
        "qr-unit-black" :
          "padding"  : 0
          "margin"   : 0 
          "width"    : "4px"
          "height"   : "4px"
          'background'    : '#000000'
          "border-radius" : 0
        "qr-unit-white" :
          "padding"  : 0
          "margin"   : 0 
          "width"    : "4px"
          "height"   : "4px"
          "border-radius" : 0
          'background'    : '#FFFFFF'

        "qr-label" :
          "text-align" : 'center'
          "font-size"  : '12px'
          "color"      :  '#000000'

    #单个点的大小,以px为单位
    set_unit_size: (@unit_size) =>  
      @unit_size = Math.floor(@unit_size)
      @qr_height = @unit_size*@height 
      @qr_width = @unit_size*@width
      @generate_css()         

    set_is_radius: (@is_radius) =>   @generate_css()        #是否圆角
    set_b_color: (@b_color) =>   @generate_css()            #背景色
    set_f_color: (@f_color) =>  @generate_css()             #前景色
  
    set_label: (@label) =>   @generate_css()                #文字信息
    set_font_size: (@font_size) =>  @generate_css()         #字体大小
    set_font_color: (@font_color) =>  @generate_css()       #字体颜色
  
    set_show_logo: (@show_logo) => @generate_css()
    set_logo_url: (@logo_url) =>  @generate_css()           #图标
  
    set_logo_width: (@logo_width) => @generate_css()
    set_logo_height: (@logo_height) =>  @generate_css()
  
    #根据当前设置生成css样式代码
    #返回object {'selector' : css_object}
    generate_css: =>
      #设置大小
      @css['qr-unit-black']['width'] = "#{@unit_size}px"
      @css['qr-unit-black']['height'] = "#{@unit_size}px"
      @css['qr-unit-white']['width'] = "#{@unit_size}px"
      @css['qr-unit-white']['height'] = "#{@unit_size}px"

      #设置颜色
      @css['qr-unit-black']['background'] = "#{@f_color}"
      @css['qr-unit-white']['background'] = "#{@b_color}"
      #设置圆角
      if @is_radius
        @css['qr-unit-black']['border-radius'] = '5px'
        @css['qr-unit-white']['border-radius'] = '5px'
      else
        @css['qr-unit-black']['border-radius'] = 0
        @css['qr-unit-white']['border-radius'] = 0
  
      #设置显示文字
      if @label
        @css['qr-label']['font-size'] = "#{@font_size}px"
        @css['qr-label']['color'] = "#{@font_color}"
  
      #设置logo居中
      @calculate_logo_xy()
      @css['qr-logo']['left'] = "#{@logo_left}px"
      @css['qr-logo']['top'] = "#{@logo_top}px"
      @css['qr-logo']['width'] = "#{@logo_width}px"
      @css['qr-logo']['height'] = "#{@logo_height}px"
      if @show_logo
        @css['qr-logo']['display'] = ""
      else
        @css['qr-logo']['display'] = "none"

      $(this).trigger('css_change')

    #计算Logo图标所在位置
    calculate_logo_xy: =>
      @logo_left = Math.floor((@qr_width - @logo_width) / 2)
      @logo_top = Math.floor((@qr_height - @logo_height) / 2)
 
    css2style:  =>
      ret =  new Object()
      for selector of @css
        style = ""
        for att of @css[selector]
          style += "#{att} : #{@css[selector][att]};"
  
        ret[selector] = style
  
      ret

    #将css对象转换为字符串
    to_string:  =>
      ret = ""
      for selector of @css
        ret +=".#{selector} {"
        for att of @css[selector]
          ret += "#{att} : #{@css[selector][att]};\n\r"

        ret += "}\n\r"
      ret


  
  
  #二维码设置显示
  class QrConfigView 
    constructor: (@el,@qr_config) ->
      #根据qr_config设置view的初始值
      $(@el).find('.front-colorpicker').val(@qr_config.f_color)
      $(@el).find('.back-colorpicker').val(@qr_config.b_color)
      $(@el).find('.unit-size-slider').val(@qr_config.unit_size)
      $(@el).find('.radius-slider').val(if @qr_config.is_radius then 1 else 0)
      $(@el).find('.font-size-slider').val(@qr_config.font_size)
      $(@el).find('.font-colorpicker').val(@qr_config.font_color)
      $(@el).find('.show-logo-slider').val(if @qr_config.show_logo then 1 else 0)
      $(@el).find('.txt-qr-label').val(@qr_config.label)
      @start()
  
    start : =>
      #绑定相关事件
      $(@el).on('change','.front-colorpicker', =>
        f_color = $('.front-colorpicker').val()
        @qr_config.set_f_color(f_color)
      )
      $(@el).on('change','.back-colorpicker', =>
        b_color = $('.back-colorpicker').val()
        @qr_config.set_b_color(b_color)
      )
      $(@el).on('unit-size-slide','.unit-size-slider', =>
        unit_size = $('.unit-size-slider').val()
        @qr_config.set_unit_size(unit_size)
      )
  
      $(@el).on('radius-slide','.radius-slider', =>
        is_radius = $('.radius-slider').val()
        @qr_config.set_is_radius(is_radius)
      )
      $(@el).on('show-logo-slide','.show-logo-slider', =>
        show_logo = $('.show-logo-slider').val()
        @qr_config.set_show_logo(show_logo)
      )
 
      $(@el).on('change','.txt-qr-label', =>
        qr_label = $('.txt-qr-label').val()
        @qr_config.set_label(qr_label)
      )
      $(@el).on('font-size-slide','.font-size-slider', =>
        font_size = $('.font-size-slider').val()
        @qr_config.set_font_size(font_size)
      )
  
      $(@el).on('change','.font-colorpicker', =>
        font_color = $('.font-colorpicker').val()
        @qr_config.set_font_color(font_color)
      )
      #设置图标
      $(@el).on('click','.btn-set-logo',(evt) =>
        target_el = $(evt.currentTarget)
        logo_url = $(target_el).data('absolute-logo-url')
        @qr_config.set_logo_url(logo_url)
      )
  
  #二维码显示
  class QrView
    constructor : (@qr_wrapper_el,@qr_config) ->
      $(@qr_config).on("css_change",@on_qr_config_change)
  
    #二维码设这变化处理
    on_qr_config_change : =>
      style_hash = @qr_config.css2style()
      $(@qr_wrapper_el).find(".qr-label").html(@qr_config.label)
      $(@qr_wrapper_el).find(".qr-logo").attr('src',@qr_config.logo_url)
      for selector of style_hash
        $(@qr_wrapper_el).find(".#{selector}").attr('style','').attr('style',style_hash[selector])
  
  #以下初始化代码
  options = 
    width :   $('.large-qr .qr-wrapper').data('width')
    height:   $('.large-qr .qr-wrapper').data('height')
    label :   $('.large-qr .qr-wrapper').data('label')
    logo_url: $('.large-qr .qr-wrapper').data('logo-url')
    is_radius : true
    unit_size : 6
 

  qr_config = new QrConfig(options)
  qr_config_view = new QrConfigView($('.qr-config'),qr_config)
  qr_view = new QrView($('.large-qr'),qr_config)
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
    $('#qr_code_img_url').html(origin_qr_code_img_url+"?"+$.param(qr_options : qr_object))
  )
  #trigger event
  qr_config.generate_css()

  #针对批量上传图片时,只能使用默认样式
  for qr_el in $('.small-qr .qr-wrapper')
    options = 
      width :   $(qr_el).data('width')
      height:   $(qr_el).data('height')
      logo_url: $(qr_el).data('logo-url')
      label:    ""

    qr_config = new QrConfig(options)
    qr_view = new QrView($(qr_el),qr_config)
    qr_config.generate_css()
    qr_object = 
      css : qr_config.to_string()
      qr_width : qr_config.qr_width + 20
      qr_height : qr_config.qr_height + 20

    $(qr_el).data('qr-object',qr_object)
