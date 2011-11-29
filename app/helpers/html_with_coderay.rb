class HTMLWithCoderay < Redcarpet::Render::HTML
  def block_code(code, language)
    language = language.blank? ? "text" : language
    CodeRay.scan(code, language).div
  end

  def header(text, header_level)
    tag = "h#{header_level}"
    text_as_id = text.parameterize
    %Q{<#{tag} id="#{text_as_id}">#{text}</#{tag}>}
  end
end
