# -*- coding: utf-8 -*-
require 'spec_helper'

describe "FriendlyForwardings" do
  subject { page }

  describe "for non-signed-in users" do
    let(:user) { FactoryGirl.create(:user) }

    describe "когда пытается посетить закрытую страницу" do
      before do
        visit edit_user_path(user)
        fill_in "Адрес электронной почты:", with: user.email
        fill_in "Пароль:", with: user.password
        click_button "Войти"
      end

      describe "после того как авторизовался" do

        it "должен передать желанную защищенную страницы" do
          page.should have_selector('title', text: 'Редактирование профиля')
        end
      end
    end
  end
end
