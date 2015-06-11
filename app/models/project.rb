class Project < ActiveRecord::Base
  has_many :font_sets
  after_save :clear_cache

  validate :valid_kit
  validates :title, presence: true
  validates :primary_color, css_color: true, if: :primary_color
  validates :secondary_color, css_color: true, if: :secondary_color

  # TODO Add photo overlay color attribute

  def kit
    # Loading kit from file as the internet sucks
    all = GoogleFonts.new.all['items']
    if collection_url
      collection = collection_url.split('/Collection:').last.split('|')
      collection = collection.map { |name| name.gsub('+', ' ') }
      @kit = all.select { |font| collection.include?(font['family']) }
    else
      @kit = all
    end
  end

  def slug
    title.parameterize
  end

  def compiled_css
    sass = ''
    sass += font_sets.map(&:uncompiled_sass).join
    sass += primary_color_sass if primary_color
    sass += secondary_color_sass if secondary_color
    Sass::Engine.new(sass, syntax: :scss).to_css
  end

  private

  def primary_color_sass
    <<-END
    .project-#{slug} {
      span.byline {
        a, a:link, a:active, a:visited {
          color: #{primary_color};
        }
      }
      .m-row .m-row__inner blockquote {
        color: #{primary_color};
      }

      .m-row .m-row__inner span.number {
        color: #{primary_color};
      }
    }
    END
  end

  def secondary_color_sass
    <<-END
      .project-#{slug} {
        .-overlay-color:before {
          background: rgba(#{secondary_color}, 0.35);
        }

        .m-row .m-row__inner q span {
          color: #{secondary_color};
        }
      }
    END
  end

  def clear_cache
    Rails.cache.delete("google_fonts")
  end

  def valid_kit
    # if kit['errors']
    #   message = "There's a problem with your kit: #{kit['errors'].join(', ')}"
    #   errors.add(:base, message)
    # end
  end
end
