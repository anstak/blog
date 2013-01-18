# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do

  before { @user = User.new(name:"Example User",email:"user@example.com",password:"foobar",password_confirmation:"foobar") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_token)}
  it { should respond_to(:autor)}
  it { should respond_to(:admin)}

  it { should be_valid }

  describe "Имя не задано" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "Имя слишком короткое" do
    before { @user.name = "a"*3 }
    it { should_not be_valid }
  end
  describe "email не задан" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "Формат email неверный" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |invalid_address|
      before { @user.email = invalid_address }
      it { should_not be_valid }
    end
  end
  describe "Формат email верный" do
    addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      before { @user.email = valid_address }
      it { should be_valid }
    end
  end
  describe "когда email уже занят" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  describe "когда пароль существует" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  describe "когда пароль подтвержден неправильно" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  describe "когда пароль не подтвержден" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  describe "когда пароль слишком короткий" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
  describe "возвращает значение метода authenticate" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "с правильным паролем" do
      it { should == found_user.authenticate(@user.password)}
    end
    describe "с неправильным паролем" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
