#通用操作
$ ->
  $('.nav').on('click','li', (evt) -> 
    delegate_el = $(evt.delegateTarget)
    delegate_el.find('li').removeClass('active')
    el = $(evt.target)
    el.parent('li').addClass('active')
  )
  $('[data-toggle="tooltip"]').tooltip()

