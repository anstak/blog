class StaticPagesController < ApplicationController
  def home
    @posts = Post.paginate(page: params[:page]).per_page(5)
  end
end
