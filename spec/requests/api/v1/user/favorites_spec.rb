require 'rails_helper'

describe 'Favorites API' do
  it 'sends a list of favorites' do
    user = create(:user)
    create_list(:favorite, 3, user_id: user.id)

    get "/api/v1/user/favorites?api_key=#{user.api_key}"

    favorites = JSON.parse(response.body)
    expect(response).to be_successful
    expect(favorites.count).to eq(3)
  end
end
