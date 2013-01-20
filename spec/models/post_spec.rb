# -*- coding: utf-8 -*-
require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @post = user.posts.build(name:"Lorem ipsum", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Suscipit ea quasi quam veritatis ullam maiores")
  end

  subject { @post }

  it { should respond_to(:name) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "когда user_id не задан" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "доступность аттрибутов" do
    it "должен быть запрещен доступ к user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
