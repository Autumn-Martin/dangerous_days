require 'rails_helper'

describe 'Search for the most dangerous day' do
  context 'by guest user' do
    it 'reveals the most dangerous day' do
      visit root_path
      fill_in :start_date, with: "2018-01-01"
      fill_in :end_date, with: "2018-01-07"
      click_on "Determine Most Dangerous Day"

      expect(current_path).to eq(most_dangerous_day_path)
      expect(page).to have_content("Most Dangerous Day")
      expect(page).to have_content("January 1, 2018 - January 7, 2018")

      within(first(".neo")) do
        expect(page).to have_css(".name")
        expect(page).to have_css(".reference_id")
      end
    end
    # The data appears to have changed. If it hadn't, the test below should pass.
    xit 'displays the info expected by the user story' do
      visit root_path
      fill_in :start_date, with: "2018-01-01"
      fill_in :end_date, with: "2018-01-07"
      click_on "Determine Most Dangerous Day"

      within(".most_dangerous_day") do
        expect(page).to have_content("January 1, 2018")
      end
      expect(page).to have_css(".neo", count: 3)

      expect(page).to have_content("Name: (2014 KT76)")
      expect(page).to have_content("NEO Reference ID: 3672906")

      expect(page).to have_content("Name: (2014 KT76)")
      expect(page).to have_content("NEO Reference ID: 3672906")

      expect(page).to have_content("Name: (2017 YR1)")
      expect(page).to have_content("NEO Reference ID: 3794979")
    end
  end
end

## User story:
# As a guest user
# When I visit "/"
# And I enter "2018-01-01" into the start date
# And I enter "2018-01-07" into the end date
# And I click "Determine Most Dangerous Day"
#
# Then I should be on "/most_dangerous_day"
# And I should see a heading for "Most Dangerous Day"
# And I should see "January 1, 2018 - January 7, 2018"
# And I should see a heading for the most dangerous day in that range "January 1, 2018"
# And I should see 3 asteroids in that list
#
# And I should see "Name: (2014 KT76)"
# And I should see "NEO Reference ID: 3672906"
#
# And I should see "Name: (2001 LD)"
# And I should see "NEO Reference ID: 3078262"
#
# And I should see "Name: (2017 YR1)"
# And I should see "NEO Reference ID: 3794979"
