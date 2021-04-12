require 'rails_helper'

describe Video do
  describe 'associations' do
    it { should belong_to :category }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end
end