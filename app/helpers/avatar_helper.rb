module AvatarHelper
  def avatar_image_url_for(model_instance, email=nil)
    if model_instance.respond_to?(:email)
      email = model_instance.email
    end

    if model_instance.respond_to?(:avatar_image) && model_instance.avatar_image.attached? && model_instance.avatar_image.variable?
      url_for(model_instance.avatar_image)
    elsif email.present?
      gravatar_url_for(email)
    else
      "https://static.licdn.com/aero-v1/sc/h/9c8pery4andzj6ohjkjp54ma2"
    end
  end

  def gravatar_url(email:, **options)
    hash = Digest::MD5.hexdigest(email&.downcase || '')
    options.reverse_merge!(default: :mp, rating: :pg, size: 500)
    "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
  end
end
