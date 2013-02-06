# -*- coding: utf-8 -*-
require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: user) }

  before do
    @comment = post.comments.build(content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Suscipit ea quasi quam veritatis ullam maiores")
  end

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:post_id) }

  it { should be_valid }

  describe "доступность аттрибутов" do
    it "должен быть запрещен доступ к user_id" do
      expect do
        Comment.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "с пустым контентом" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end
  describe "когда контент слишком короткий" do
    before { @comment.content = "a" * 5 }
    it { should_not be_valid }
  end

end
