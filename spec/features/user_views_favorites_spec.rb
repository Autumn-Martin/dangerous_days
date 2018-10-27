require 'rails_helper'

describe 'Request for favorites' do
  context 'by a registered user' do
    xit 'displays a users favorite neos' do
      visit api_v1_user_favorites_path

      json_response = [
                        {
                          "id":1,
                          "neo_reference_id": "2153306",
                          "user_id": 1,
                          "asteroid": {
                            "name": "153306 (2001 JL1)",
                            "is_potentially_hazardous_asteroid": false,
                          }
                        }
                      ]

      expect(page).to have_content(json_response)
    end
  end
end


# ```
# As a registered user
# When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123'
# Then I should receive a JSON response as follows:
# ```
#
# ```
# [
#   {
#     "id":1,
#     "neo_reference_id": "2153306",
#     "user_id": 1,
#     "asteroid": {
#       "name": "153306 (2001 JL1)",
#       "is_potentially_hazardous_asteroid": false,
#     }
#   }
# ]
# ```
