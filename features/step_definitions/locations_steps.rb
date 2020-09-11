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

When('I click on the new location button') do
  click_link 'New Location'
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