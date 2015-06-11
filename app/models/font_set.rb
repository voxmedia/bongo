class FontSet < ActiveRecord::Base
  ELEMENTS = %w(main_headline secondary_headline body byline pullquote blockquote big_number big_number_label)
  belongs_to :project

  validate :valid_sass
  validates :name, :main_headline, :secondary_headline, :body, :byline,
            :pullquote, :blockquote, :big_number, :big_number_label, presence: true

  def slug
    name.parameterize if name
  end

  def element_font_name(element)
    return unless ELEMENTS.include?(element)
    family(element)['name']
  end

  def element_css(element)
    return unless ELEMENTS.include?(element)
    font_family = "font-family:#{family(element)['css_stack']};"
    font_weight = "font-weight:#{weight(element)};"
    font_style = "font-style:#{style(element)};"
    font_family + font_weight + font_style
  end

  def uncompiled_sass
    elements_css = ELEMENTS.map do |e|
      ".bng-#{e.gsub('_', '-')} { #{element_css(e)} } " if instance_eval(e)
    end.join
    ".fontset-#{slug} { #{elements_css} #{sass} }"
  end

  def compiled_css
    Sass::Engine.new(uncompiled_sass, syntax: :scss).to_css
  end

  private

  def family_id(element)
    instance_eval(element).split(':').first
  end

  def family(element)
    project.kit['kit']['families'].find { |u| u['id'] == family_id(element) }
  end

  def variation(element)
    instance_eval(element).split(':').last
  end

  def style(element)
    styles = { 'n' => 'normal', 'i' => 'italic', 'o' => 'oblique' }
    styles[variation(element).first]
  end

  def weight(element)
    variation(element).last.to_i * 100
  end

  def valid_sass
    Sass::Engine.new(uncompiled_sass, syntax: :scss).to_css
  rescue Sass::SyntaxError
    message = 'There is a syntax error in your styles'
    errors.add(:base, message)
  end
end
