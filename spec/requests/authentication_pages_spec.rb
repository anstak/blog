# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Авторизация" do
  subject { page }

  describe "страница авторизации" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Авторизация') }
    it { should have_selector('title', text: 'Авторизация') }
  end

  describe "залогинимся" do
    before { visit signin_path }

    describe "с неправильной информацией" do
      before { click_button "Войти" }

      it { should have_selector('title', text: 'Авторизация') }
      it { should have_selector('div.alert.alert-error') }

      describe "после перехода на другую страницу" do
        before { click_link "Главная" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    describe "с правильной информацией" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Адрес электронной почты:", with: user.email
        fill_in "Пароль:", with: user.password
        click_button "Войти"
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Профиль', href: user_path(user)) }
      it { should have_link('Выйти', href: signout_path) }
      it { should_not have_link('Войти', href: signin_path) }
    end
  end
end
