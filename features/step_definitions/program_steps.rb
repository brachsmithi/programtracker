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

Given('I am on page {int} of the program index') do |int|
  visit '/programs'
  within '.top_pager' do
    click_link '2'
  end
  within '.top_pager' do
    expect(page).to have_link('1')
  end
end

Given('I have run a program search') do
  create_program 'Program 1'
  create_program 'Program 2'
  visit '/programs'
  run_search 'program 2'
end

Given('there is a program on multiple discs') do
  create_program_on_multiple_discs
end

Given('there is a program on no discs') do
  create_program 'No Love'
end

Given('that I am on the edit page for a program in a cluster') do
  p = create_fully_loaded_program_in_a_cluster

  visit "/programs/#{p.id}/edit"
end

Given('that I am on the edit page for a program not in a cluster') do
  p = create_fully_loaded_program_with_no_cluster

  visit "/programs/#{p.id}/edit"
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
    find('.search').click #trigger input onchange
    click_button 'Set Director'
  end
  click_link 'Add Series'
  within '.series-program-fields:nth-of-type(1)' do
    click_link 'Select series'
  end
  within '#modal-window' do
    fill_in 'select_search', with: created_program[:series_search]
    find('.search').click #trigger input onchange
    click_button 'Set Series'
  end
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

  # change director by first deleting the current one
  within '.programs-director-fields:nth-of-type(1)' do
    click_on(class: 'remove_fields')
  end

  # now add the desired director
  click_link 'Add Director'
  click_link 'Select director'
  within '#modal-window' do
    fill_in 'select_search', with: edited_program[:director_search_term]
    find('.search').click #trigger input onchange
    click_button 'Set Director'
  end
  
  click_link 'Add Series'
  within '.series-program-fields:nth-of-type(2)' do
    click_link 'Select series'
  end
  within '#modal-window' do
    fill_in 'select_search', with: edited_program[:series_search]
    find('.search').click #trigger input onchange
    click_button 'Set Series'
  end

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

When('I return to the program index page') do
  click_link 'Program List'
  expect(page).to have_content('Program Index')
end

When('I click to see the duplicates report') do
  click_link 'Duplicates Report'
end

When('I click to see the unused report') do
  click_link 'Unused Report'
end

When('I choose to create a new version of the program') do
  click_link 'New Version'
  expect(page).to have_content("part of cluster with #{edited_program_in_cluster[:original_version]}")
end

When('I save the new version of the program') do
  fill_in 'Version', with: edited_program_in_cluster[:new_version]

  click_link 'Update'
  expect(page).to have_content(edited_program_in_cluster[:name])
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
  expect(page).to have_content(edited_program[:edit_director_name])
  expect(page).to have_content(edited_program[:edit_series_name])

  expect(page).to have_no_content('Program Index')
  expect(page).to have_no_selector(id: 'form')
  expect(page).to have_no_content(edited_program[:original_director_name])
end

Then('the program search still applies') do
  expect(page).to have_content('Program 2')

  expect(page).to have_no_content('Program 1')
end

Then('the program is listed as duplicated') do
  expect(page).to have_content('Duplicated Programs')
  expect(page).to have_content('So Many Copies')

  expect(page).to have_link('Unused Report')
  expect(page).to have_link('Program List')
end

Then('the program is listed as unused') do
  expect(page).to have_content('Unused Programs')
  expect(page).to have_content('No Love')

  expect(page).to have_link('Duplicates Report')
  expect(page).to have_link('Program List')
end

Then('the new version of the program is in the program cluster') do
  expect(page).to have_content(edited_program_in_cluster[:name])
  expect(page).to have_content(edited_program_in_cluster[:new_version])
  expect(page).to have_content(edited_program_in_cluster[:year])
  expect(page).to have_content(edited_program_in_cluster[:director_name_1])
  expect(page).to have_content(edited_program_in_cluster[:director_name_2])
  expect(page).to have_content(edited_program_in_cluster[:series_name_1])
  expect(page).to have_content(edited_program_in_cluster[:series_name_2])
  expect(page).to have_content(edited_program_in_cluster[:alternate_title_1])
  expect(page).to have_content(edited_program_in_cluster[:alternate_title_2])
  expect(page).to have_link('part of cluster')
  expect(page).to have_link(edited_program_in_cluster[:original_version])
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

def create_program_on_multiple_discs
  p = create_program 'So Many Copies'
  l = Location.create!(name: 'Someplace')
  d1 = Disc.create!({
    location: l,
    format: 'DVD',
    state: 'FILED'
  })
  d2 = Disc.create!({
    location: l,
    format: 'Blu-ray',
    state: 'VIEWING'
  })
  DiscProgram.create!({
    program: p,
    disc: d1,
    program_type: 'FEATURE'
  })
  DiscProgram.create!({
    program: p,
    disc: d2,
    program_type: 'FEATURE'
  })
  p
end

def create_fully_loaded_program_in_a_cluster 
  p = create_fully_loaded_program_for_cluster
  pvc = ProgramVersionCluster.create!
  pvc.programs << p
  p 
end

def create_fully_loaded_program_with_no_cluster
  create_fully_loaded_program_for_cluster
end

def create_fully_loaded_program_for_cluster
  p = Program.create!({
    name: edited_program_in_cluster[:name],
    sort_name: edited_program_in_cluster[:sort_name],
    year: edited_program_in_cluster[:year],
    version: edited_program_in_cluster[:original_version],
    minutes: edited_program_in_cluster[:length]
  })
  p.directors << create_director(edited_program_in_cluster[:director_name_1])
  p.directors << create_director(edited_program_in_cluster[:director_name_2])
  p.series << create_series(edited_program_in_cluster[:series_name_1])
  p.series << create_series(edited_program_in_cluster[:series_name_2])
  AlternateTitle.create(program: p, name: edited_program_in_cluster[:alternate_title_1])
  AlternateTitle.create(program: p, name: edited_program_in_cluster[:alternate_title_2])
  p 
end