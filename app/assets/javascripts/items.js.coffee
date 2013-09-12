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
    $('.selected-info').html("请选定商品进行操作")

#获取当前界面选定的商品的id数组
get_selected_item_ids = ->
  selected_items = $('.cbx-select-item:checked:enabled')
  selected_ids = $.map(selected_items,(el) -> $(el).val())


#更新选定的商品条码到taobao对应的服务器上
$('.btn-update-to-items-describe').on('click', ->
  setting = 
    data: 
      ids : get_selected_item_ids()
    type: 'PUT'
    dataType: 'script'
  $.fancybox.showLoading()
  $.blockUI(message : '正在更新,请稍候...')

  hide_loading = ->
    $.unblockUI()
    $.fancybox.hideLoading()

  $.ajax("items/img_upload.js",setting).then(hide_loading,hide_loading)
)

