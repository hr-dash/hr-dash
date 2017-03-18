$ ->
  marked.setOptions({
    gfm: true,
    sanitize: true,
    breaks: true,
    highlight: (code) ->
      hljs.highlightAuto(code).value
  })

  emojify.setConfig({
    img_dir: '/images/emoji/'
  })

  rickDom = new RickDOM()

  $(document).on 'click', '.tab-md-preview', ->
    content = $(this).closest('.markdown-editor').find('.markdown-content')
    text = content.find('textarea').val()
    preview = content.find('.content-md-preview')
    preview.html(rickDom.build(marked(text)))
    emojify.run(content[0])

  $('.markdown-view').each (i, view) ->
    text = $(view).find('textarea').val()
    body = $(view).find('.markdown-body')
    body.html(rickDom.build(marked(text)))
    emojify.run(view)

  hljs.initHighlightingOnLoad()

  # 他サイトへのリンクはtarget _blank指定
  $("a[href^='http']:not([href*='" + location.hostname + "'])")
    .attr('target', '_blank')
