require 'rails_helper'

describe 'Favorites API' do
  it 'creates a new favorite' do
    user = create(:user, id: 1)
    favorite_params = { neo_reference_id: '2021277', user_id: user.id }
    all_params = { api_key: user.api_key, favorite: favorite_params }

    post "/api/v1/user/favorites", params: all_params

    favorite = Favorite.last
    received_info = JSON.parse(response.body, symbolize_names: true)
    expected_info = { "id": favorite.id,
                      "neo_reference_id": "2021277",
                      "user_id": 1,
                      "asteroid": {
                        "name": "21277 (1996 TO5)",
                        "is_potentially_hazardous_asteroid": false,
                      }
                    }

    expect(response).to be_successful
    expect(favorite.neo_reference_id).to eq(favorite_params[:neo_reference_id])
    expect(received_info).to eq(expected_info)
  end
end


# ```
# When I send a POST request to "/api/v1/user/favorites" with an 'api_key' of 'abc123' and a 'neo_reference_id' of '2021277'
# Then I should receive a response with a status code of 200
# And the body should be JSON as follows:
# ```
#
# ```
# {
#   "id":2,
#   "neo_reference_id": "2021277",
#   "user_id": 1,
#   "asteroid": {
#     "name": "21277 (1996 TO5)",
#     "is_potentially_hazardous_asteroid": false,
#   }
# }
