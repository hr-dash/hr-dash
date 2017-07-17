$ ->
  $('.daily_report_comment_edit').click ->
    id = $(this).find('[name=comment_id]').val()
    panel = $(this).closest('.panel')

    $.ajax({
      url: "/daily_report_comments/#{id}/edit",
      dataType: "html"
      success: (html) ->
        panel.replaceWith(html)
    })
