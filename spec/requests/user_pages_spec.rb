# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Страница пользователя" do

  subject { page }

  describe "страница регистрации" do
    before { visit new_user_path }
    it {should have_selector('h1', text:'Регистрация')}
    it {should have_selector('title', text:'Регистрация')}
  end
  describe "страница пользователей" do
    before { visit users_path }
    it {should have_selector('h1', text:'Авторы')}
    it {should have_selector('title', text:'Авторы')}
  end
  describe "страница профиля" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
    it { should have_selector('img.gravatar') }
  end

  describe "Регистрация" do
    before { visit new_user_path }

    let(:submit) { "Зарегистрироваться" }

    describe "с неправильными данными" do
      it "не должно создать пользователя" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "после клика на странице должно быть" do
        before { click_button submit }
        it { should have_selector('title', text: 'Регистрация') }
        it { should have_selector('div.alert.alert-error') }
        it { should_not have_content('Password digest') }
      end
    end
    describe "с правильными данными" do
      before do
        fill_in "Имя пользователя", with: "Example User"
        fill_in "Адрес электронной почты", with: "user@example.com"
        fill_in "Пароль:", with: "foobar"
        fill_in "Ещё раз пароль:", with: "foobar"
      end
      it "должно создать пользователя" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "после сохранения должно быть на странице" do
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Выход') }
      end
    end
  end
end


