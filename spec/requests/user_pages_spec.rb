# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Страница пользователя" do

  subject { page }
  after(:all)  { User.delete_all }

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
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Выйти') }
      end
    end
  end

  describe "редактирование" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "на странице должно быть" do
      it { should have_selector('h1',    text: "Редактирование профиля") }
      it { should have_selector('title', text: "Редактирование профиля") }
      it { should have_link('Изменить аватар', href: 'http://gravatar.com/emails') }
    end

    describe "с неправильной информацией" do
      before { click_button "Сохранить" }
      it { should have_selector('div.alert.alert-error') }
    end

    describe "с правильной информацией" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Имя пользователя:", with: new_name
        # fill_in "Адрес электронной почты:", with: new_email
        fill_in "Пароль:", with: user.password
        fill_in "Ещё раз пароль:", with: user.password
        click_button "Сохранить"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Выйти', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      # specify { user.reload.email.should == new_email }
    end
  end

  describe "index пользователей" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'Авторы блога') }
    it { should have_selector('h1',    text: 'Авторы блога') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "должен показать каждого пользователя" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "ссылки удаления пользователей" do
      it { should_not have_link('удалить') }

      describe "для админа" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('удалить', href: user_path(User.first)) }
        it "может удалить другого пользователя" do
          expect { click_link('удалить') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('удалить', href: user_path(admin)) }
      end
    end

  end
end


