# -*- coding: utf-8 -*-

require 'spec_helper'

describe "Страница пользователя" do

  subject { page }

  describe "страница Регистрации" do
    before { visit new_user_path }

    it {should have_selector('h1', text:'Регистрация')}
    it {should have_selector('title', text:'Регистрация')}
  end

  describe "страница Пользователей" do
    before { visit users_path }

    it {should have_selector('h1', text:'Авторы')}
    it {should have_selector('title', text:'Авторы')}
  end
end
