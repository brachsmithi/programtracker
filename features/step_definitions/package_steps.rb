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

Given('I am on the create package page') do
  visit '/packages/new'
end

Given('I am on the edit package page') do
  p = create_edit_package\
  
  visit "/packages/#{p.id}/edit"
end

When('I click on the new package button') do
  click_link 'New Package'
end

When('I create a package') do
  fill_in 'Name', with: created_package[:name]
  click_link 'Create'
end

When('I edit the package') do
  fill_in 'Name', with: edited_package[:edit_name]
  within '.disc:nth-of-type(1)' do
    fill_in 'Sequence', with: edited_package[:discs][0][:edit_sequence]
  end
  within '.disc:nth-of-type(2)' do
    fill_in 'Sequence', with: edited_package[:discs][1][:edit_sequence]
  end
  click_link 'Update'
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

Then('I should see the package on a display page') do
  expect(page).to have_content(created_package[:name])

  expect(page).to have_no_content('Package Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the package display page') do
  expect(page).to have_content(edited_package[:edit_name])
  expect(page).to have_content(edited_package[:discs][0][:edit_sequence])
  expect(page).to have_content(edited_package[:discs][1][:edit_sequence])

  expect(page).to have_no_content('Package Index')
  expect(page).to have_no_selector(id: 'form')
end