Given('I am on the location index page') do
  visit '/locations'
end

Given('there are {int} pages of locations') do |int|
  total = int * 15
  (1..total).each do |num|
    create_location "Location #{num}"
  end
end

Given('there is one location') do
  create_location
end

Given('I am on the create location page') do
  visit '/locations/new'
end

Given('I am on the edit location page') do
  location = create_edit_location

  visit "/locations/#{location.id}/edit"
end

Given('I am on page {int} of the location index') do |int|
  visit '/locations'
  within '.top_pager' do
    click_link '2'
  end
  within '.top_pager' do
    expect(page).to have_link('1')
  end
end

Given('I have run a location search') do
  create_location 'Location 1'
  create_location 'Location 2'
  visit '/locations'
  run_search 'location 2'
end

When('I click on the new location button') do
  click_link 'New Location'
end

When('I create a location') do
  fill_in 'Name', with: created_location[:name]
  click_link 'Create'
end

When('I edit the location') do
  fill_in 'Name', with: edited_location[:edit_name]
  click_link 'Update'
end

When('I return to the location index page') do
  click_link 'Location List'
end

Then('I should see the location page') do
  expect(page).to have_content(default_location[:name])

  expect(page).to have_no_content('Location Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the location edit page') do
  expect(page).to have_content('Edit Location')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Location Index')
end

Then('I should see the new location page') do
  expect(page).to have_content('New Location')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Location Index')
end

Then('I should see the location on a display page') do
  expect(page).to have_content(created_location[:name])

  expect(page).to have_no_content('Location Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the location display page') do
  expect(page).to have_content(edited_location[:edit_name])

  expect(page).to have_no_content('Location Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('the location search still applies') do
  expect(page).to have_content('Location 2')

  expect(page).to have_no_content('Location 1')
end

# HELPER METHODS

def create_location name = default_location[:name]
  Location.create! name: name
end

def create_edit_location
  Location.create!(name: edited_location[:original_name])
end