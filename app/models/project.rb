class Project < ActiveRecord::Base
  has_many :font_sets
  before_save :update_slug
  after_save :clear_cache

  validate :valid_kit
  validates :title, :kit_id, :typekit_token, presence: true

  def kit
    json = Rails.cache.fetch("typekit:#{self.kit_id}") {
      Typekit.new(self.typekit_token).get_kit_info(self.kit_id)
    }
  end

  def compiled_css
    sass = ""
    self.font_sets.each do |f|
      sass += f.uncompiled_sass
    end

    if !self.primary_color.nil?
      sass += <<-END
      .project-#{self.slug} {
        span.byline {
          a, a:link, a:active, a:visited {
            color: #{self.primary_color};
          }
        }
        .m-row .m-row__inner blockquote {
          color: #{self.primary_color};
        }

        .m-row .m-row__inner span.number {
          color: #{self.primary_color};
        }
      }
      END
    end

    if !self.secondary_color.nil?
      sass += <<-END
        .project-#{self.slug} {
          .-overlay-color:before {
            background: rgba(#{self.secondary_color}, 0.35);
          }

          .m-row .m-row__inner q span {
            color: #{self.secondary_color};
          }
        }
      END
    end
    begin
      Sass::Engine.new(sass, { syntax: :scss }).to_css
    rescue Sass::SyntaxError
      ''
    end
  end

  protected

  def clear_cache
    Rails.cache.delete("typekit:#{self.kit_id}")
  end

  def update_slug
    self.slug = self.title.parameterize
  end

  def valid_kit
    if kit['errors']
      message = "There's a problem with your kit: #{kit['errors'].join(', ')}"
      errors.add(:base, message)
    end
  end
end
