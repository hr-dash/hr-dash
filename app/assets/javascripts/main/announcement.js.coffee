$ ->
  $('.announcement-link').on 'click', ->
    id = $(this).attr('data-target')
    $('#' + id).modal()
