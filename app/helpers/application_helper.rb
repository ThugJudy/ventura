module ApplicationHelper
  def author_of(resource)
    user_signed_in? && resource.user_id == current_user.id
  end

  def gravatar_for(user, options = { size: 32})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "border-radius-50")
  end

  def admin?
    user_signed_in? && current_user.admin? 
  end
  def uname? id
    User.find(id).name
  end
end
