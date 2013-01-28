# -*- coding: utf-8 -*-
class CommentsController < ApplicationController

  def create
    @current_post = Post.find_by_id(params[:comment][:post_id])
    @newcomment = Comment.new(params[:comment])
    @comments = @current_post.comments
    if signed_in?
      @newcomment.user_id = current_user.id
    else
      @newcomment.user_id = 0
    end
    if @newcomment.save
      flash[:success] = "Комментарий успешно создан!"
      redirect_to post_path(@current_post.id)
    else
      render :template => 'posts/show'
    end
  end

end
