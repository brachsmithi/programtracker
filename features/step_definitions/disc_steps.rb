Given('I am on the disc index page') do
  visit "/discs"
end

Given('there are {int} pages of discs') do |int|
  total = int * 15
  (1..total).each do |num|
    create_disc "Disc #{num}"
  end
end

Given('there is one disc') do
  create_disc
end

When('I click on the new disc button') do
  click_link 'New Disc'
end

Then('I should see the disc page') do
  expect(page).to have_content(default_disc[:name])
  expect(page).to have_content(default_disc[:location_page])
  expect(page).to have_content(default_disc[:format])
  expect(page).to have_content(default_disc[:state])

  expect(page).to have_no_content('Disc Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the disc edit page') do
  expect(page).to have_content('Edit Disc')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Disc Index')
end

Then('I should see the new disc page') do
  expect(page).to have_content('New Disc')
  expect(page).to have_selector(id: 'form')
  
  expect(page).to have_no_content('Disc Index')
end