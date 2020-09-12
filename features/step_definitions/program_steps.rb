Given('I am on the program index page') do
  visit "/programs"
end

Given('I am on the create program page') do
  create_director created_program[:director_name]
  create_series created_program[:series_name]

  visit "/programs/new"
end

Given('I am on the edit program page') do
  program = create_edit_program

  visit "/programs/#{program.id}/edit"
end

Given('there is one program') do
  create_program default_program[:name]
end

Given('there are {int} pages of programs') do |int|
  total = int * 15
  (1..total).each do |num|
    create_program "Program #{num}"
  end
end

When('I create a program with all fields and associations') do
  fill_in 'Name', with: created_program[:name]
  fill_in 'Sort name', with: created_program[:sort_name]
  fill_in 'Year', with: created_program[:year]
  fill_in 'Version', with: created_program[:version]
  fill_in 'Length', with: created_program[:length]
  click_link 'Add Director'
  click_link 'Select director'
  within '#modal-window' do
    fill_in 'select_search', with: created_program[:director_search_term]
    find('.programs').click #trigger input onchange
    click_button 'Set Director'
  end
  click_link 'Add Series'
  select(created_program[:series_name], from: 'Series')
  click_link 'Add Alternate Title'
  within '.alternate-title-fields' do
    fill_in 'Name', with: created_program[:alternate_title]
  end
  click_link 'Create'
end

When('I edit the program') do
  fill_in 'Name', with: edited_program[:edit_name]
  fill_in 'Sort name', with: edited_program[:edit_sort_name]
  fill_in 'Year', with: edited_program[:edit_year]
  fill_in 'Version', with: edited_program[:edit_version]
  fill_in 'Length', with: edited_program[:edit_length]

  # cannot edit or remove director yet, so add another
  click_link 'Add Director'
  click_link 'Select director'
  within '#modal-window' do
    fill_in 'select_search', with: edited_program[:director_search_term]
    find('.programs').click #trigger input onchange
    click_button 'Set Director'
  end
  
  select(edited_program[:edit_series_name], from: 'Series')

  # cannot edit or remove alternate title yet, so add another
  click_link 'Add Alternate Title'
  within '.alternate-title-fields' do
    fill_in 'Name', with: edited_program[:edit_alternate_title]
  end
  click_link 'Update'
end

When('I click on the new program button') do
  click_link 'New Program'
end

When('I run a search') do
  fill_in 'search', with: '9'
  find('#search').native.send_keys(:return)
end

Then('I should see the program page') do
  expect(page).to have_content(default_program[:name])

  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the program edit page') do
  expect(page).to have_content('Edit Program')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Program Index')
end

Then('I should see the new program page') do
  expect(page).to have_content('New Program')
  expect(page).to have_selector(id: 'form')
  
  expect(page).to have_no_content('Program Index')
end

Then('I should see the program with associations on a display page') do
  expect(page).to have_content(created_program[:name_display])
  expect(page).to have_content(created_program[:version])
  expect(page).to have_content(created_program[:length_display])
  expect(page).to have_content(created_program[:alternate_title])
  expect(page).to have_content(created_program[:director_name])
  expect(page).to have_content(created_program[:series_name])

  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the program display page') do
  expect(page).to have_content(edited_program[:name_display])
  expect(page).to have_content(edited_program[:edit_version])
  expect(page).to have_content(edited_program[:length_display])
  expect(page).to have_content(edited_program[:original_alternate_title])
  expect(page).to have_content(edited_program[:edit_alternate_title])
  expect(page).to have_content(edited_program[:original_director_name])
  expect(page).to have_content(edited_program[:edit_director_name])
  expect(page).to have_content(edited_program[:edit_series_name])

  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
end

# HELPER METHODS

def create_program name = default_program[:name]
  Program.create!(name: name)
end

def create_edit_program
  p = Program.create!({
    name: edited_program[:original_name],
    sort_name: edited_program[:origianl_sort_name],
    year: edited_program[:original_year],
    version: edited_program[:original_version],
    minutes: edited_program[:original_length]
  })
  p.directors << create_director(edited_program[:original_director_name])
  p.series << create_series(edited_program[:original_series_name])
  AlternateTitle.create(program: p, name: edited_program[:original_alternate_title])
  create_director(edited_program[:edit_director_name])
  create_series(edited_program[:edit_series_name])
  p
end