# -*- coding: utf-8 -*-

require 'spec_helper'

describe "Статическая страница" do

  subject { page }

  describe "Главная страница" do
    before {visit root_path}

    describe "должна иметь правильное содержение тегов" do
      it { should have_selector('title', text: 'Главная') }
      it { should have_selector('h1', text: 'Последние заметки') }
    end

  end

  it "должна иметь правильные ссылки" do
    visit root_path
    click_link "Регистрация"
    should have_selector('title', text: 'Регистрация')
    click_link "Авторы"
    should have_selector('title', text: 'Авторы')
  end
end
