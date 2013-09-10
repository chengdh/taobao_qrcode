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
  )
  #选定全部商品
  $('.cbx-select-item-all').on('click',(evt) ->
    el = $(evt.target)
    if el.prop('checked')
      $('.cbx-select-item').prop('checked',true)
    else
      $('.cbx-select-item').prop('checked',false)
    update_selected_info()
  )

  #更新商品选择信息
  update_selected_info = ->
    selected_items = $('.cbx-select-item:checked:enabled').length
    if selected_items > 0
      $('.selected-info').html("已选定#{selected_items}个商品")
    else
      $('.selected-info').html("请选择商品进行操作")
