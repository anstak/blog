# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Post pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "создание поста" do
    before { visit new_post_path }

    describe "с правильной информацией" do

      it "не должен создать пост" do
        expect { click_button "Создать" }.not_to change(Post, :count)
      end

      describe "сообщение об ошибка" do
        before { click_button "Создать" }
        it { should have_selector('div.alert.alert-error') }
      end
    end

    describe "с правильной информацией" do

      before do
       fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
       fill_in 'post_name', with: "Lorem ipsum dolor"
     end
      it "должен создать пост" do
        expect { click_button "Создать" }.to change(Post, :count).by(1)
      end
    end
  end

  describe "страница с постами пользователя" do
    before do
      FactoryGirl.create(:post, user: user, name: "Lorem ipsum", content:"Lorem ipsum dolor sit, consectetur")
      FactoryGirl.create(:post, user: user, name: "Dolor sit amet", content:"Lorem ipsum dolor sit amet")
      visit user_posts_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
      end
    end
  end
end
