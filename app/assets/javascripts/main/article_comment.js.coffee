$ ->
  $('.article_comment_edit').click ->
    id = $(this).find('[name=comment_id]').val()
    panel = $(this).closest('.panel')

    $.ajax({
      url: "/article_comments/#{id}/edit",
      dataType: "html"
      success: (html) ->
        panel.replaceWith(html)
    })
