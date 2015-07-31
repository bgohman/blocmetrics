module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Blocmetrics"
    if page_title.empty?
      base_title
    else
      base_title + " | " + page_title
    end
  end

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end
end
