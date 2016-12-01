module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-warning"
    end
  end

  def form_image_select(post)
    return image_tag post.image.url(:medium), 
                      id: 'image-preview',
                      class: 'img-responsive' if post.image.exists?
    image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
  end

end
