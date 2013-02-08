class TagsController < ApplicationController
  def show
    @current_tag = Tag.find_by_id(params[:id])
    @tag_posts = @current_tag.posts.paginate(page: params[:page]).per_page(10)
  end
end
