# -*- coding: utf-8 -*-
include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Адрес электронной почты:", with: user.email
  fill_in "Пароль:", with: user.password
  click_button "Войти"
  #Sign in when not using Capybara
  cookies[:remember_token] = user.remember_token
end
