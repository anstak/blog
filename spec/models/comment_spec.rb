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

end
