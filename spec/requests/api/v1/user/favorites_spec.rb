require 'rails_helper'

describe 'Favorites API' do
  it 'sends a list of favorites' do
    user = create(:user)
    create_list(:favorite, 3, user_id: user.id)

    get "/api/v1/user/favorites?api_key=#{user.api_key}"

    favorites = JSON.parse(response.body)

    expect(response).to be_successful
    expect(favorites.count).to eq(3)

    expect(favorites[0]).to have_key("id")
    expect(favorites[0]).to have_key("neo_reference_id")
    expect(favorites[0]).to have_key("user_id")
    expect(favorites[0]).to have_key("asteroid")
    expect(favorites[0]["asteroid"]).to have_key("name")
    expect(favorites[0]["asteroid"]).to have_key("is_potentially_hazardous_asteroid")
  end

  it 'sends the info expected by the user story' do
    user = create(:user, id: 1)
    favorite = create(:favorite, id: 1, user_id: user.id, neo_reference_id: "2153306")

    get "/api/v1/user/favorites?api_key=#{user.api_key}"

    favorites = JSON.parse(response.body, symbolize_names: true)

    expected_info = [{  "id":1,
                        "neo_reference_id": "2153306",
                        "user_id": 1,
                        "asteroid": { "name": "153306 (2001 JL1)",
                                      "is_potentially_hazardous_asteroid": false,
                                    }
                    }]
    expect(response).to be_successful
    expect(favorites.count).to eq(1)
    expect(favorites).to eq(expected_info)
  end
end
