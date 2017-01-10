$ ->
  marked.setOptions({
    gfm: true,
    sanitize: true,
    highlight: (code) ->
      hljs.highlightAuto(code).value
  })

  rickDom = new RickDOM()

  $(document).on 'click', '.tab-md-preview', ->
    content = $(this).closest('.markdown-editor').find('.markdown-content')
    text = content.find('textarea').val()
    preview = content.find('.content-md-preview')
    preview.html(rickDom.build(marked(text)))

  $('.markdown-view').each (i, view) ->
    text = $(view).find('textarea').val()
    body = $(view).find('.markdown-body')
    body.html(rickDom.build(marked(text)))

  hljs.initHighlightingOnLoad()
