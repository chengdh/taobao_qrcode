$ ->
  #初始化items/index帮助系统
  help_steps = []
  help_steps.push(->
    $('.items-toggle').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000' 
        opacity:         0.2 
        border : '2px dotted gray'
    )
    txt = "切换在售宝贝/橱窗推荐宝贝"
    $('.items-toggle').grumble(
      text:  txt
      angle: 90
      distance: -50 
    )
  )

  help_steps.push(->
    $('.items-toggle').unblock()
    $('.items-toggle').grumble('hide')

    txt = "您的宝贝列表,点击上部复选框选择一个或多个宝贝进行操作,点击宝贝图片进入详细界面"
    $('.items-list').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '3px dotted gray'
    )
    $('.items-list').grumble(
      text: txt 
      angle: 90 
      distance: -50 
    )
  )
  help_steps.push(->
    $('.items-list').unblock()
    $('.items-list').grumble('hide')

    $('.items-operate').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '2px dotted gray'
    )
    txt_1 = "在这里操作您选择的宝贝,可以批量上传至淘宝或打包成压缩文件下载"
    $('.items-operate').grumble(
      text:  txt_1
      angle: 270 
      distance: 80 
    )
  )
  help_steps.push(->
    $('.items-operate').grumble('hide')
    $('.items-operate').unblock()

    $('.items-search-form').block(
      message : null
      overlayCSS:   
        backgroundColor: '#000'
        opacity:         0.1
        border : '2px dotted gray'
    )

    txt_2 = "在这里输入查询条件查找特定的宝贝信息"
    $('.items-search-form').grumble(
      text:  txt_2
      angle: 270 
      distance: 80 
    )
  )

  help_steps.push(-> 
    $('.items-search-form').grumble('hide')
    $('.items-search-form').unblock()
  )

  if $('.items-index-first-visit').length > 0
    help_model = new window.help_system.HelpModel(help_steps)
    help_view = new window.help_system.HelpView(help_model)
