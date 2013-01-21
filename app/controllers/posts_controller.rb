# -*- coding: utf-8 -*-
class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy, :edit]

  def show
    @feed_items = current_user.feed.paginate(page: params[:page])
    @user = current_user
  end

  def new
    @newpost = current_user.posts.build if signed_in?
    @user = current_user
  end

  def create
    @newpost = current_user.posts.build(params[:post])
    if @newpost.save
      flash[:success] = "Статья успешно создана!"
      redirect_to user_posts_path
    else
      render new_post_path
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path
  end

  private
    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to user_posts_path if @post.nil?
    end
end
