$ ->
  #初始化shops/current帮助系统
  help_steps = []
  help_steps.push(->
    $('.large-qr').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000' 
        opacity:         0.2 
        border : '2px dotted gray'
    )
    txt = "这是宝贝网址二维码,手机扫描后可以直接进入宝贝详情页面,您也可以将它放置在任何需要显示的地方"
    $('.large-qr').grumble(
      text:  txt
      angle: 30
      distance: 100 
    )
  )

  help_steps.push(->
    $('.large-qr').unblock()
    $('.large-qr').grumble('hide')

    txt = "您可以通过它来设置二维码的外观,包括颜色、大小、标签、图标等"
    $('.qr-config').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '3px dotted gray'
    )
    $('.qr-config').grumble(
      text: txt 
      angle: 30 
      distance: 200 
    )
  )
  help_steps.push(->
    $('.qr-config').unblock()
    $('.qr-config').grumble('hide')

    $('.qr-operates-upload').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '2px dotted gray'
    )
    txt_1 = "您可通过这两个按钮将二维码上传到淘宝或下载到本地永久保存"
    $('.qr-operates-upload').grumble(
      text:  txt_1
      angle: 180 
      distance: 0 
    )
  )
  help_steps.push(->
    $('.qr-operates-upload').grumble('hide')
    $('.qr-operates-upload').unblock()

    $('.qr-operates-share').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '2px dotted gray'
    )

    txt_2 = "您可通过这些分享按钮将店铺二维码方便、快捷的分享到各个地方"
    $('.qr-operates-share').grumble(
      text:  txt_2
      angle: 180 
      distance: 0 
    )
  )

  help_steps.push(-> 
    $('.qr-operates-share').grumble('hide')
    $('.qr-operates-share').unblock()
    txt = "您也可拷贝二维码图片的网址,并放到需要显示的地方"
    $('.qr-url').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '2px dotted gray'
    )
 
    $('.qr-url').grumble(
      text:     txt
      angle:    180
      distance: -50 
    )
  )
  help_steps.push(-> $('.qr-url').grumble('hide');$('.qr-url').unblock())

  if $('.items-show-first-visit').length > 0
    help_model = new window.help_system.HelpModel(help_steps)
    help_view = new window.help_system.HelpView(help_model)
