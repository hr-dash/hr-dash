module ApplicationHelper
  def markdown(text)
    GitHub::Markdown.render_gfm(h(text))
  end

  def alert_class_for(flash_type)
    types = {
      success: 'alert-success',
      notice: 'alert-info',
      alert: 'alert-warning',
      error: 'alert-danger',
    }
    types[flash_type.to_sym]
  end
end
