class FontSet < ActiveRecord::Base
  belongs_to :project

  def element_font_name(element)
    begin
      family_id = self.instance_eval(element).split(':').first
      family = self.project.kit['kit']['families'].find { |u| u['id'] == family_id }
      family['name']
    rescue
      ''
    end
  end

  def element_css(element)
    begin
      family_id = self.instance_eval(element).split(':').first
      variation_id = self.instance_eval(element).split(':').last
      s = variation_id.first
      style = case s
      when "n"
        "normal"
      when "i"
        "italic"
      when "o"
        "oblique"
      end
      weight = variation_id.last.to_i * 100
      family = self.project.kit['kit']['families'].find { |u| u['id'] == self.instance_eval(element).split(':').first }
      "font-family:#{family['css_stack']};font-weight:#{weight};font-style:#{style}"
    rescue
      ''
    end
  end
end
