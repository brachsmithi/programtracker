Given('I am on the director index page') do
  visit '/directors'
end

Given('there are {int} pages of directors') do |int|
  total = int * 15
  (1..total).each do |num|
    create_director "Director #{num}"
  end
end

Given('there is one director') do
  create_director
end

When('I click on the new director button') do
  click_link 'New Director'
end

Then('I should see the director page') do
  expect(page).to have_content(default_director[:name])

  expect(page).to have_no_content('Director Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the director edit page') do
  expect(page).to have_content('Edit Director')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Director Index')
end

Then('I should see the new director page') do
  expect(page).to have_content('New Director')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Director Index')
end