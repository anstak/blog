# -*- coding: utf-8 -*-
class PostsController < ApplicationController
  before_filter :signed_in_user

  def new
    @newpost = current_user.posts.build if signed_in?
  end

  def create
    @newpost = current_user.posts.build(params[:post])
    if @newpost.save
      flash[:success] = "Статья успешно создана!"
      redirect_to root_url
    else
      render new_post_path
    end
  end

  def destroy
  end
end
