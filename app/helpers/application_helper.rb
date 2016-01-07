module ApplicationHelper
  def markdown(text)
    RDiscount.new(text, :autolink, :filter_html, :generate_toc)
  end
end
