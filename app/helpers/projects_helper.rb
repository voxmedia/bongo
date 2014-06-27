module ProjectsHelper
  def project_background_image_style(url)
    unless url.nil?
      "style=\"background-image: url(#{url})\"".html_safe
    end
  end

  def project_image_tag(url, opts = {})
    unless url.nil?
      image_tag(url, opts)
    end
  end
end
