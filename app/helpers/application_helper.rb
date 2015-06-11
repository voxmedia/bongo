module ApplicationHelper
  def font_variation_to_string(v)
    style = ['', 'regular'].include?(v[/\D*/]) ? 'normal' : v[/\D*/]
    weight = v[/\d*/].empty? ? '400' : v[/\d*/]
    "#{style} #{weight}"
  end

  def font_variation_to_css(v)
    style = font_style_to_string(v[0])
    weight = v[1].to_i * 100
    "font-style:#{style};font-weight:#{weight};"
  end
end
