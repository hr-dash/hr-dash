$ ->
  marked.setOptions({
    gfm: true,
    breaks: true,
    sanitize: true,
    highlight: (code) ->
      hljs.highlightAuto(code).value
  })

  $('.tab-md-preview').click ->
    content = $(this).closest('.markdown-editor').find('.markdown-content')
    text = content.find('textarea').val()
    preview = content.find('.content-md-preview')
    preview.html(marked(text))
