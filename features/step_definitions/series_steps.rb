Given('I am on the series index page') do
  visit '/series'
end

Given('there are {int} pages of series') do |int|
  total = int * 15
  (1..total).each do |num|
    create_series "Series #{num}"
  end
end

Given('there is one series') do
  create_series
end

When('I click on the new series button') do
  click_link 'New Series'
end

Then('I should see the series page') do
  expect(page).to have_content(default_series[:name])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the series edit page') do
  expect(page).to have_content('Edit Series')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Series Index')
end

Then('I should see the new series page') do
  expect(page).to have_content('New Series')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Series Index')
end