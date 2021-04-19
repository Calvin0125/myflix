require 'rails_helper.rb'

describe Review do
  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:video).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:body) }
  end
end