# -*- coding: utf-8 -*-
class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy, :update, :edit]

  def show
    @current_post = Post.find_by_id(params[:id])
  end

  def new
    @newpost = current_user.posts.build if signed_in?
    @user = current_user
  end

  def create
    @newpost = current_user.posts.build(params[:post])
    @user = current_user
    if @newpost.save
      flash[:success] = "Статья успешно создана!"
      redirect_to articles_path(@user)
    else
      render new_post_path
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Статья удалена."
    redirect_to articles_path(@post.user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @post.update_attributes(params[:post])
      flash[:success] = "Статья успешно обновлена."
      redirect_to edit_post_path(@post)
    else
      render 'edit'
    end
  end

  private
    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to user_posts_path if @post.nil?
    end
end
