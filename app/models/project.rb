class Project < ActiveRecord::Base
  has_many :font_sets
  before_save :update_slug

  def kit
    typekit = Typekit.new(self.typekit_token)
    json = typekit.get_kit_info(self.kit_id)
  end

  def compiled_css
    css = ""
    self.font_sets.each do |f|
      css += f.compiled_css
    end
    css
  end

  protected

  def update_slug
    self.slug = self.title.parameterize
  end
end
