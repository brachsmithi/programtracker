Given('I am on the disc index page') do
  visit "/discs"
end

Given('I am on the create disc page') do
  create_location created_disc[:location_name]
  create_package created_disc[:package_name]
  created_disc[:programs].each do |pn|
    create_program pn[:name]
  end

  visit "/discs/new"
end

Given('I am on the edit disc page') do
  disc = create_edit_disc

  visit "/discs/#{disc.id}/edit"
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

When('I create a disc with all fields and associations') do
  fill_in 'Name', with: created_disc[:name]
  select(created_disc[:format], from: 'Format')
  select(created_disc[:state], from: 'State')
  select(created_disc[:location_name], from: 'Location')
  select(created_disc[:package_name], from: 'Package')
  within '.disc_program_fields' do
    select(created_disc[:programs][0][:program_type], from: 'Program type')
    fill_in 'Sequence', with: created_disc[:programs][0][:sequence]
    click_link 'Select program'
  end
  within '#modal-window' do
    fill_in 'select_search', with: created_disc[:programs][0][:search_term]
    find('.programs').click #trigger input onchange
    click_button 'Set Program'
  end
  click_link 'Add Program'
  within '.disc_program_fields:nth-of-type(2)' do
    select(created_disc[:programs][1][:program_type], from: 'Program type')
    fill_in 'Sequence', with: created_disc[:programs][1][:sequence]
    click_link 'Select program'
  end
  within '#modal-window' do
    fill_in 'select_search', with: created_disc[:programs][1][:search_term]
    find('.programs').click #trigger input onchange
    click_button 'Set Program'
  end
  click_link 'Create'
end

When('I edit the disc') do
  fill_in 'Name', with: edited_disc[:edit_name]
  select(edited_disc[:edit_format], from: 'Format')
  select(edited_disc[:edit_state], from: 'State')
  select(edited_disc[:edit_location_name], from: 'Location')
  select(edited_disc[:edit_package_name], from: 'Package')
  click_link 'remove'
  click_link 'Add Program'
  within '.disc_program_fields' do
    select(edited_disc[:edit_program][:program_type], from: 'Program type')
    fill_in 'Sequence', with: edited_disc[:edit_program][:sequence]
    click_link 'Select program'
  end
  within '#modal-window' do
    fill_in 'select_search', with: edited_disc[:edit_program][:search_term]
    find('.programs').click #trigger input onchange
    click_button 'Set Program'
  end
  click_link 'Update'
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

Then('I should see the disc with associations on a display page') do
  expect(page).to have_content(created_disc[:name])
  expect(page).to have_content(created_disc[:format])
  expect(page).to have_content(created_disc[:state])
  expect(page).to have_content(created_disc[:package_name])
  expect(page).to have_content(created_disc[:location_name])
  expect(page).to have_content(created_disc[:programs][0][:name])
  expect(page).to have_content(created_disc[:programs][0][:program_type])
  expect(page).to have_content(created_disc[:programs][1][:name])
  expect(page).to have_content(created_disc[:programs][1][:program_type])

  expect(page).to have_no_content('Disc Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the disc display page') do
  expect(page).to have_content(edited_disc[:edit_name])
  expect(page).to have_content(edited_disc[:edit_format])
  expect(page).to have_content(edited_disc[:edit_state])
  expect(page).to have_content(edited_disc[:edit_package_name])
  expect(page).to have_content(edited_disc[:edit_location_name])
  expect(page).to have_content(edited_disc[:edit_program][:name])
  expect(page).to have_content(edited_disc[:edit_program][:program_type])

  expect(page).to have_no_content('Disc Index')
  expect(page).to have_no_selector(id: 'form')
end