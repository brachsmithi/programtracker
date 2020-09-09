Given('I am on the program index page') do
  visit "/programs"
end

Given('I am on the create program page') do
  Director.create(name: 'Director Person')
  Series.create(name: 'Film Franchise')

  visit "/programs/new"
end

Given('there is one program') do
  Program.create(name: "My Program")
end

Given('there are two pages of programs') do
  (1..16).each do |num|
    Program.create(name: "Program #{num}")
  end
end

Given('I create a program with all of the basic fields') do
  fill_in 'Name', with: '1st Created Program'
  fill_in 'Sort name', with: 'First Created Program'
  fill_in 'Year', with: '2020'
  fill_in 'Version', with: 'Theatrical Cut'
  fill_in 'Length', with: '90'
  click_link 'Create'
end

Given('I create a program with all associations') do
  fill_in 'Name', with: '2nd Created Program'
  click_link 'Add Director'
  click_link 'Select director'
  within '#modal-window' do
    fill_in 'select_search', with: 'pers'
    find('.programs').click #trigger input onchange
    click_button 'Set Director'
  end
  click_link 'Add Series'
  select('Film Franchise', :from => 'Series')
  click_link 'Add Alternate Title'
  within '.alternate-title-fields' do
    fill_in 'Name', with: 'Created Program 2'
  end
  click_link 'Create'
end

When('I click on the new program button') do
  click_link 'New Program'
end

Then('I should see the last page') do
  expect(page).to have_no_link('Next')
end

Then('I should see the program page') do
  expect(page).to have_content('My Program')
  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the program edit page') do
  expect(page).to have_content('Edit Program')
  expect(page).to have_no_content('Program Index')
  expect(page).to have_selector(id: 'form')
end

Then('I should see the new program page') do
  expect(page).to have_content('New Program')
  expect(page).to have_no_content('Program Index')
  expect(page).to have_selector(id: 'form')
end

Then('I should see the program basics on a display page') do
  expect(page).to have_content('1st Created Program (2020)')
  expect(page).to have_content('Theatrical Cut')
  expect(page).to have_content('1 hr 30 min')
  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the program with associations on a display page') do
  expect(page).to have_content('2nd Created Program')
  expect(page).to have_content('Created Program 2')
  expect(page).to have_content('Director Person')
  expect(page).to have_content('Film Franchise')

  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
end