class Project < ActiveRecord::Base
  has_many :font_sets
  validates :title, presence: true
  validates :primary_color, css_color: true, if: :primary_color
  validates :secondary_color, css_color: true, if: :secondary_color
  validates :overlay_color, css_color: true, if: :overlay_color

  def kit
    # Loading kit from file as the internet sucks
    all = GoogleFonts.new.all['items']
    if collection_url && collection_url['/Collection:']
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
    sass += overlay_color_sass if overlay_color
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
      .m-row .m-row__inner q span {
        color: #{secondary_color};
      }
    END
  end

  def overlay_color_sass
    <<-END
   .m-row .m-row__box.half.has_background_image:before, .m-row .m-row__box.third.has_background_image:before, .m-row .m-row__inner .text.feature:before {
      background-color: rgba(#{overlay_color}, 0.5);
    }
    END
  end
end
