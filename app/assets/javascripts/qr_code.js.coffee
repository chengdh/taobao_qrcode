#定义与qr_code相关的类
#
#二维码设置类
$ ->
  class QrConfig
    constructor: (@height,@width)->
      #@height 二维码高度
      #@width 二维码宽度
      @unit_size = 4          #单个点的大小,以px为单位
      @is_radius = false      #是否圆角
      @b_color = '#FFFFFF'    #背景色
      @f_color = '#000000'    #前景色
  
      @label =  ""            #文字信息
      @font_size = 12         #字体大小
      @font_color = "#000000" #字体颜色
  
      @logo_url = ""          #图标
  
      @logo_width = 40
      @logo_height = 40
      @logo_left = 0          #图标左方位坐标
      @logo_top = 0           #上方位坐标
  
  
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
      @generate_css()         

    set_is_radius: (@is_radius) =>   @generate_css()        #是否圆角
    set_b_color: (@b_color) =>   @generate_css()            #背景色
    set_f_color: (@f_color) =>  @generate_css()             #前景色
  
    set_label: (@label) =>   @generate_css()                #文字信息
    set_font_size: (@font_size) =>  @generate_css()         #字体大小
    set_font_color: (@font_color) =>  @generate_css()       #字体颜色
  
    set_logo_url: (@logo_url) =>  @generate_css()          #图标
  
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
        @css['qr-label']['color'] = "'#{@font_color}'"
  
      #设置logo居中
      @calculate_logo_xy()
      @css['qr-logo']['left'] = "#{@logo_left}px"
      @css['qr-logo']['top'] = "#{@logo_top}px"
      @css['qr-logo']['width'] = "#{@logo_width}px"
      @css['qr-logo']['height'] = "#{@logo_height}px"
      $(this).trigger('css_change')
  
    @css2style:  (css_object)->
      ret =  new Object()
      for selector of css_object
        style = ""
        for att of css_object[selector]
          style += "#{att} : #{css_object[selector][att]};"
  
        ret[selector] = style
  
      ret
  
    #计算Logo图标所在位置
    calculate_logo_xy: =>
      qr_height = @unit_size * @height
      qr_width = @unit_size * @width
      @logo_left = (qr_width - @logo_width) / 2
      @logo_top = (qr_height - @logo_height) / 2
  
  #二维码设置显示
  class QrConfigView 
    constructor: (@el,@qr_config) ->
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
        logo_url = $(target_el).data('logo-url')
        @qr_config.set_logo_url(logo_url)
      )
  
  #二维码显示
  class QrView
    constructor : (@qr_wrapper_el,@qr_config) ->
      $(@qr_config).on("css_change",@on_qr_config_change)
  
    #二维码设这变化处理
    on_qr_config_change : =>
      style_hash = QrConfig.css2style(@qr_config.css)
      $(@qr_wrapper_el).find(".qr-label").html(@qr_config.label)
      $(@qr_wrapper_el).find(".qr-logo").attr('src',@qr_config.logo_url)
      for selector of style_hash
        $(@qr_wrapper_el).find(".#{selector}").attr('style','').attr('style',style_hash[selector])
  
  #以下初始化代码
  qr_config = new QrConfig($('.qr-wrapper').data('width'),$('.qr-wrapper').data('height'))
  qr_config_view = new QrConfigView($('.qr-config'),qr_config)
  qr_view = new QrView($('.qr-wrapper'),qr_config)
  #trigger event
  $(qr_config).trigger('css_change')
