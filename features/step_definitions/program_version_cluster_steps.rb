Given('I am on the program version cluster index page') do
  visit '/program_version_clusters'
end

Given('there are {int} pages of program version clusters') do |int|
  total = int * 15
  (1..total).each do |num|
    create_program_version_cluster
  end
end

Given('there is one program version cluster') do
  create_program_version_cluster
end

Given('there is one program version cluster with program') do
  pvc = create_program_version_cluster
  pvc.programs << create_program
  pvc
end

Given('I am on the create program version cluster page') do
  visit '/program_version_clusters/new'
end

Given('I am on the edit program version cluster page') do
  pvc = create_edit_program_version_cluster

  visit "/program_version_clusters/#{pvc.id}/edit"
end

Given('I am on page {int} of the program version cluster index') do |int|
  visit '/program_version_clusters'
  within '.top_pager' do
    click_link '2'
  end
  within '.top_pager' do
    expect(page).to have_link('1')
  end
end

Given('I am on the edit page for a cluster with two programs') do
  pvc = create_edit_programs_edit_program_version_cluster

  visit "/program_version_clusters/#{pvc.id}/edit"
end

When('I click on the new program version cluster button') do
  click_link 'New Cluster'
end

When('I create a program version cluster with associations') do
  Program.create!({
    name: created_program_version_cluster[:programs][0][:name],
    version: created_program_version_cluster[:programs][0][:version]
  })
  Program.create!({
    name: created_program_version_cluster[:programs][1][:name],
    version: created_program_version_cluster[:programs][1][:version]
  })
  click_link 'Add Program'
  click_link 'Select program'
  within '#modal-window' do
    fill_in 'select_search', with: created_program_version_cluster[:programs][0][:search_term]
    find('.search').click #trigger input onchange
    click_button 'Set Program'
  end
  click_link 'Add Program'
  click_link 'Select program'
  within '#modal-window' do
    fill_in 'select_search', with: created_program_version_cluster[:programs][1][:search_term]
    find('.search').click #trigger input onchange
    click_button 'Set Program'
  end
  click_link 'Create'
end

When('I edit the program version cluster') do
  click_link 'Add Program'
  click_link 'Select program'
  within '#modal-window' do
    fill_in 'select_search', with: edited_program_version_cluster[:search_term]
    find('.search').click #trigger input onchange
    select(edited_program_version_cluster[:edit_program][:search_name], from: 'selected_id_value')
    click_button 'Set Program'
  end
  click_link 'Update'
end

When('I return to the program version cluster index page') do
  click_link 'Cluster List'
  expect(page).to have_content('Program Version Cluster Index')
end

When('I edit the program fields') do
  fill_in 'Name', with: edited_programs_edit_program_version_cluster[:edit_name]
  fill_in 'Sort name', with: edited_programs_edit_program_version_cluster[:edit_sort_name]
  fill_in 'Year', with: edited_programs_edit_program_version_cluster[:edit_year]

  # director
  # series
  # alternate title
  click_link 'Update'
end

Then('I should see the program version cluster page') do
  expect(page).to have_content('Program Version Cluster')

  expect(page).to have_no_content('Program Version Cluster Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the program version cluster edit page') do
  expect(page).to have_content('Edit Cluster')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Program Version Cluster Index')
end

Then('I should see the new program version cluster page') do
  expect(page).to have_content('New Cluster')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Program Version Cluster Index')
end

Then('I should see the program version cluster with associations on a display page') do
  expect(page).to have_content(created_program_version_cluster[:programs][0][:name])
  expect(page).to have_content(created_program_version_cluster[:programs][0][:version])
  expect(page).to have_content(created_program_version_cluster[:programs][1][:version])

  expect(page).to have_no_content(created_program_version_cluster[:programs][1][:name])
  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the program version cluster display page') do
  expect(page).to have_content(edited_program_version_cluster[:programs][0][:name])
  expect(page).to have_content(edited_program_version_cluster[:programs][0][:version])
  expect(page).to have_content(edited_program_version_cluster[:programs][1][:version])
  expect(page).to have_content(edited_program_version_cluster[:edit_program][:version])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('the cluster changes should be visible on the first program') do
  click_link edited_programs_edit_program_version_cluster[:programs][0][:version]

  within 'h1' do
    expect(page).to have_content('Program')
  end
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:edit_name])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:edit_sort_name])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:edit_year])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:programs][0][:version])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:programs][0][:display_length])
end

Then('the cluster changes should be visible on the second program') do
  click_link edited_programs_edit_program_version_cluster[:programs][1][:version]

  within 'h1' do
    expect(page).to have_content('Program')
  end
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:edit_name])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:edit_sort_name])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:edit_year])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:programs][1][:version])
  expect(page).to have_content(edited_programs_edit_program_version_cluster[:programs][1][:display_length])
end

# HELPER METHODS

def create_program_version_cluster
  ProgramVersionCluster.create!
end

def create_edit_program_version_cluster
  pvc = create_program_version_cluster
  p1 = Program.create!({
    name: edited_program_version_cluster[:programs][0][:name],
    version: edited_program_version_cluster[:programs][0][:version]
  })
  p2 = Program.create!({
    name: edited_program_version_cluster[:programs][1][:name],
    version: edited_program_version_cluster[:programs][1][:version]
  })
  pvc.programs << p1
  pvc.programs << p2
  Program.create!({
    name: edited_program_version_cluster[:edit_program][:name],
    version: edited_program_version_cluster[:edit_program][:version]
  })
  pvc
end

def create_edit_programs_edit_program_version_cluster
  pvc = create_program_version_cluster
  p1 = Program.create!({
    name: edited_programs_edit_program_version_cluster[:programs][0][:name],
    sort_name: edited_programs_edit_program_version_cluster[:programs][0][:sort_name],
    version: edited_programs_edit_program_version_cluster[:programs][0][:version],
    minutes: edited_programs_edit_program_version_cluster[:programs][0][:length],
    year: edited_programs_edit_program_version_cluster[:programs][0][:year]
  })
  p2 = Program.create!({
    name: edited_programs_edit_program_version_cluster[:programs][1][:name],
    sort_name: edited_programs_edit_program_version_cluster[:programs][0][:sort_name],
    version: edited_programs_edit_program_version_cluster[:programs][1][:version],
    minutes: edited_programs_edit_program_version_cluster[:programs][1][:length],
    year: edited_programs_edit_program_version_cluster[:programs][0][:year]
  })
  pvc.programs << p1
  pvc.programs << p2
  pvc
end