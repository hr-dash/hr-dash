module ApplicationHelper
  def markdown(text)
    GitHub::Markdown.render_gfm(h(text))
  end
end
