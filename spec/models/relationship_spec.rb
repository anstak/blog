# -*- coding: utf-8 -*-
require 'spec_helper'

describe Relationship do

  let(:post) { FactoryGirl.create(:post) }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:relationship) { post.relationships.build(tag_id: tag.id) }

  subject { relationship }

  it { should be_valid }

end
