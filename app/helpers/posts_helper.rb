module PostsHelper
  def comment_user_name(comment)
    if comment.user_id == 0
      return "Anonimous"
    else
      return link_to User.find_by_id(comment.user_id).name, user_path(comment.user_id)
    end
  end
end
