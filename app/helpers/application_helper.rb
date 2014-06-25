module ApplicationHelper
  def font_variation_to_string(v)
    style = font_style_to_string(v[0])
    weight = v[1].to_i * 100
    "#{style} #{weight}"
  end

  def font_variation_to_css(v)
    style = font_style_to_string(v[0])
    weight = v[1].to_i * 100
    "font-style:#{style};font-weight:#{weight};"
  end

  def font_style_to_string(style)
    case style
    when "n"
      "normal"
    when "i"
      "italic"
    when "o"
      "oblique"
    end
  end
end
