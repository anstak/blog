# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Подтверждение доступов" do
  subject { page }

  describe "для незарегистрированного пользователя" do
    let(:user) { FactoryGirl.create(:user) }

    describe "в Users controller" do

      describe "посещяем страницу редактирования пользователя" do
        before { visit edit_user_path(user) }
        it { should have_selector('div.alert.alert-notice') }
        it { should have_selector('title', text: 'Авторизация') }
      end

      describe "отсылаем PUT request в Users#update действие" do
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end

    describe "в Posts controller" do

      describe "отсылаем Postt запрос в create action" do
        before { post posts_path }
        specify { response.should redirect_to(signin_path) }
      end

      describe "отсылаем DELETE запрос в destroy action" do
        before { delete post_path(FactoryGirl.create(:post)) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end

  describe "для другого залогиненого юзера" do
    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
    before { sign_in user }

    describe "посещаем страницу Users#edit" do
      before { visit edit_user_path(wrong_user) }
      it { should_not have_selector('title', text: full_title('Редактирование профиля')) }
    end

    describe "отсылаем PUT request в Users#update действие" do
      before { put user_path(wrong_user) }
      specify { response.should redirect_to(root_path) }
    end
  end

  describe "для не админа" do
    let(:user) { FactoryGirl.create(:user) }
    let(:non_admin) { FactoryGirl.create(:user) }

    before { sign_in non_admin }

    describe "отсылаем DELETE request в Users#destroy действие" do
      before { delete user_path(user) }
      specify { response.should redirect_to(root_path) }
    end
  end

  # describe "для залогиненого пользователя" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before do
  #    sign_in user
  #    visit edit_user_path(user)
  #  end

  #   describe "который хочет изменить свой email" do
  #     it { should have_selector('h1', text: "Редактирование профиля" ) }
  #     it { should have_selector("input[value='#{user.name}']" ) }
  #     it { should_not have_selector("input[value='#{user.email}']" ) }
  #   end
  # end

end
