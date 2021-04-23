require 'rails_helper.rb'

describe QueueItem do 
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end
end