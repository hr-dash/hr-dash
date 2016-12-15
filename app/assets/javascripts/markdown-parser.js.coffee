$ ->
  marked.setOptions({
    gfm: true,
    sanitize: true,
    highlight: (code) ->
      hljs.highlightAuto(code).value
  })

  $(document).on 'click', '.tab-md-preview', ->
    content = $(this).closest('.markdown-editor').find('.markdown-content')
    text = content.find('textarea').val()
    preview = content.find('.content-md-preview')
    preview.html(marked(text))

  $('.markdown-view').each (i, view) ->
    text = $(view).find('textarea').val()
    body = $(view).find('.markdown-body')
    body.html(marked(text))

  hljs.initHighlightingOnLoad()
