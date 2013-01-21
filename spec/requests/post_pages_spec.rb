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

      describe "error messages" do
        before { click_button "Создать" }
        it { should have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do

      before do
       fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
       fill_in 'post_name', with: "Lorem ipsum dolor"
     end
      it "should create a micropost" do
        expect { click_button "Создать" }.to change(Post, :count).by(1)
      end
    end
  end
end
