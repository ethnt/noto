Rails.configuration.renderer = Redcarpet::Render::HTML.new(
  with_toc_data: true,
  prettify: true
)

Rails.configuration.markdown = Redcarpet::Markdown.new(
  Rails.configuration.renderer,
  {
    tables:        true,
    autolink:      true,
    strikethrough: true,
    highlight:     true,
    footnotes:     true
  }
)
