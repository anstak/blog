# -*- coding: utf-8 -*-
module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user?(user) # это для verify_accesses
    user == current_user
  end

  def redirect_back_or(default) # это для friendly_forwarding
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location # это для friendly_forwarding
    session[:return_to] = request.url
  end

  def signed_in_user # это для verify_accesses и для постов
    unless signed_in?
      store_location # эта строка для friendly_forwarding
      redirect_to signin_url, notice: "Авторизируйтесь пожалуйста"
    end
  end
end
