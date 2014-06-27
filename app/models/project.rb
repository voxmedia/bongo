class Project < ActiveRecord::Base
  has_many :font_sets
  before_save :update_slug
  after_save :clear_cache

  validates :title, :kit_id, :typekit_token, presence: true

  def kit
    json = Rails.cache.fetch("typekit:#{self.kit_id}") {
      Typekit.new(self.typekit_token).get_kit_info(self.kit_id)
    }
  end

  def compiled_css
    css = ""
    self.font_sets.each do |f|
      css += f.compiled_css
    end
    css
  end

  protected

  def clear_cache
    Rails.cache.delete("typekit:#{self.kit_id}")
  end

  def update_slug
    self.slug = self.title.parameterize
  end
end
