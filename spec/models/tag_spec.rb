require 'spec_helper'

describe Tag do

  before { @tag = Tag.new(name:"Example") }
  subject { @tag }

  it { should respond_to(:name) }
  it { should respond_to(:relationships) }
  it { should respond_to(:posts) }

  it { should be_valid }

end
