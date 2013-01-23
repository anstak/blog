# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Post pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "создание поста" do
    before { visit new_post_path }

    describe "с неправильной информацией" do

      it "не должен создать пост" do
        expect { click_button "Создать" }.not_to change(Post, :count)
      end

      describe "сообщение об ошибке" do
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

    let!(:m1) { FactoryGirl.create(:post, user: user, name:"Lorem ipsum", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.") }
    let!(:m2) { FactoryGirl.create(:post, user: user, name:"Sit amet", content: "Suscipit ea quasi quam veritatis ullam maiores.") }
    let!(:m3) { FactoryGirl.create(:post, user: user, name:"Lorem ipsum", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.") }
    let!(:m4) { FactoryGirl.create(:post, user: user, name:"Sit amet", content: "Suscipit ea quasi quam veritatis ullam maiores.") }

    before do
      visit articles_path(user)
    end

    it { should have_selector('h1', text: "Мои статьи" )}
    it { should have_selector('.timestamp', text: m1.created_at.strftime("%d.%m.%y") )}
    it { should have_link( m1.name, href: post_path(m1) ) }
    it { should have_link( "редактировать статью", href: edit_post_path(m1) ) }
    it { should have_link( "удалить", href: post_path(m1) ) }
    it "должно показать только посты текущего юзера" do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
      end
    end

    it "должен удалить статью" do
      expect { click_link "удалить" }.to change(Post, :count).by(-1)
    end

    describe "редактирование поста" do
      before do
        click_link "редактировать статью"
      end
      it { should have_selector('h1', text: "Редактирование статьи") }
      it "должна иметь правильные поля" do
        should have_selector('input#post_name', value: m4.name)
        should have_selector('textarea#post_content', text: m4.content )
      end

      describe "с неправильной информацией" do
        before do
          fill_in 'Название статьи:', with: " "
          click_button "Сохранить"
        end
        it { should have_selector('div.alert.alert-error') }
      end
    end
  end

end
