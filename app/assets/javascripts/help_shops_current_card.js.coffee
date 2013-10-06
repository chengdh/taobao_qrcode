$ ->
  window.a = window.a + 1
  console.log(window.a)
  #初始化shops/current帮助系统
  help_steps = []
  help_steps.push(->
    $('.vcard').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000' 
        opacity:         0.2 
        border : '2px dotted gray'
    )
    txt = "这是您的店铺名片设置处,您可以修改名片上的信息,这些信息会形成二维码"
    $('.vcard').grumble(
      text:  txt
      angle: 30
      distance: 100 
    )
  )

  help_steps.push(->
    $('.vcard').unblock()
    $('.vcard').grumble('hide')
    $('.shop-card-qr').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000' 
        opacity:         0.2 
        border : '2px dotted gray'
    )
    txt = "这是您的店铺名片二维码,用手机扫描以自动加入到手机的联系人,您可将它放在任何地方"
    $('.shop-card-qr').grumble(
      text:  txt
      angle: 30
      distance: 100 
    )
  )

  help_steps.push(->
    $('.shop-card-qr').unblock()
    $('.shop-card-qr').grumble('hide')

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

  if $('.shops-current_card-first-visit').length > 0
    help_model = new window.help_system.HelpModel(help_steps)
    help_view = new window.help_system.HelpView(help_model)
