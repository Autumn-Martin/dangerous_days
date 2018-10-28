require 'rails_helper'

RSpec.describe Asteroid, type: :model do
  describe 'relationships' do
    it {should belong_to(:favorite)}
  end
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
end
