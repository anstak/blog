# -*- coding: utf-8 -*-

require 'spec_helper'

describe "Статическая страница" do

  subject { page }

  describe "Главная страница" do
    before {visit root_path}

    describe "должна иметь правильное содержение тегов" do
      it { should have_selector('title', text: 'Главная') }
      it { should have_selector('h1', text: 'Пока еще нет ни одного поста...') }
    end

  end

  it "должна иметь правильные ссылки" do
    visit root_path
    click_link "Регистрация"
    should have_selector('title', text: 'Регистрация')
    click_link "Авторы"
    should have_selector('title', text: 'Авторы')
  end

  describe "главная страница с постами" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:post, user: user1, name:"Lorem ipsum", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.") }
    let!(:m2) { FactoryGirl.create(:post, user: user1, name:"Sit amet", content: "Suscipit ea quasi quam veritatis ullam maiores.") }
    let!(:m3) { FactoryGirl.create(:post, user: user2, name:"Lorem ipsum", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.") }
    let!(:m4) { FactoryGirl.create(:post, user: user2, name:"Sit amet", content: "Suscipit ea quasi quam veritatis ullam maiores.") }

    before { visit root_path }

    it { should have_selector('title', text: 'Главная') }
    it { should have_selector('h1', text: "Последние статьи (всего #{Post.count})") }

    describe "имеет посты" do
      it { should have_content(m1.name) }
      it { should have_content(m1.content) }
      it { should have_selector('.timestamp', text: m1.created_at.strftime("%d.%m.%y") )}
      it { should have_content(m2.name) }
      it { should have_content(m2.content) }
      it { should have_selector('.timestamp', text: m2.created_at.strftime("%d.%m.%y") )}
      it "должны иметь ссылки на автора" do
        should have_link(user1.name, href: user_path(user1) )
        should have_link(user2.name, href: user_path(user2) )
        should have_link(m1.name, href: post_path(m1) )
        should have_link(m2.name, href: post_path(m2) )
      end
    end
  end
end
