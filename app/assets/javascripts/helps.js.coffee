#帮助系统
#使用blockUI和grumle显示帮助提示
$ ->
  window.help_system ||= new Object()
  window.help_system.HelpModel ||=
  class HelpModel
    #构造函数 @help_steps是帮助步骤集合
    constructor: (@help_steps=[])->
      #当前的帮助步骤
      @current_step = -1

    #添加帮助步骤
    append_help_step: (step) =>
      @help_steps.push(step)

    #开始帮助处理
    play_help: =>
      #已播放到帮助最后一步时,直接返回
      return if @is_last()
      @current_step  = @current_step+1 if not @is_last()
      @help_steps[@current_step].call(@)

    #重设播放步骤
    reset_step: => 
      @current_step = -1

    is_last: =>
      @current_step == @help_steps.length - 1

  #帮助的显示视图

  window.help_system.HelpView ||=
  class HelpView
    constructor: (@help_model) ->
      @start_help()
      #点击blockOverlay时,启动下一步的帮助
      $('.blockOverlay').on('click',@next_help)

    #开始启动帮助系统
    start_help: =>
      $.blockUI(
        message : null
        overlayCSS:   
          backgroundColor: '#000'
          opacity:         0.3
      )
      @help_model.play_help()

    #启动下一步骤的帮助
    next_help: =>
      console.log("next_help")
      if @help_model.is_last()
        $.unblockUI()
      else
        @help_model.play_help()
