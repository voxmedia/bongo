class Project < ActiveRecord::Base
  has_many :font_sets
  
  def kit
    typekit = Typekit.new(self.typekit_token)
    json = typekit.get_kit_info(self.kit_id)
  end
end
