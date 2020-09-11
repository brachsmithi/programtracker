Given('I am on the package index page') do
  visit '/packages'
end

Given('there are {int} pages of packages') do |int|
  total = int * 15
  (1..total).each do |num|
    create_package "Package #{num}"
  end
end

Given('there is one package') do
  create_package
end

When('I click on the new package button') do
  click_link 'New Package'
end

Then('I should see the package page') do
  expect(page).to have_content(default_package[:name])

  expect(page).to have_no_content('Package Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the package edit page') do
  expect(page).to have_content('Edit Package')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Package Index')
end

Then('I should see the new package page') do
  expect(page).to have_content('New Package')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Package Index')
end