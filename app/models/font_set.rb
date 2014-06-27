class FontSet < ActiveRecord::Base
  belongs_to :project
  before_save :update_slug
  
  validates :name, presence: true

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
      "font-family:#{family['css_stack']};font-weight:#{weight};font-style:#{style};"
    rescue
      ''
    end
  end

  def uncompiled_sass
    elements_css = ""
    ["main_headline", "secondary_headline", "byline", "body", "pullquote", "blockquote", "big_number", "big_number_label"].each do |e|
      elements_css += ".bng-#{e.gsub('_','-')} { #{self.element_css(e)} } "
    end
    sass = ".fontset-#{self.slug} { #{elements_css} #{self.sass} }"
  end

  def compiled_css
    begin
      Sass::Engine.new(self.uncompiled_sass, { syntax: :scss }).to_css
    rescue Sass::SyntaxError
      ''
    end
  end

  protected

  def update_slug
    self.slug = self.name.parameterize
  end
end
