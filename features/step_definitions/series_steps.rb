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

Given('I am on the create series page') do
  visit '/series/new'
end

Given('I am on the edit series page') do
  series = create_edit_series

  visit "/series/#{series.id}/edit"
end

Given('I am on page {int} of the series index') do |int|
  visit '/series'
  within '.top_pager' do
    click_link '2'
  end
  within '.top_pager' do
    expect(page).to have_link('1')
  end
end

Given('I have run a series search') do
  create_series 'Series 1'
  create_series 'Series 2'
  visit '/series'
  run_search 'series 2'
end

When('I click on the new series button') do
  click_link 'New Series'
end

When('I create a series') do
  fill_in 'Name', with: created_series[:name]

  click_link 'Create'
end

When('I edit the series') do
  fill_in 'Name', with: edited_series[:edit_name]
  within '.program:nth-of-type(1)' do
    fill_in 'Sequence', with: edited_series[:programs][0][:edit_sequence]
  end
  within '.program:nth-of-type(2)' do
    fill_in 'Sequence', with: edited_series[:programs][1][:edit_sequence]
  end
  click_link 'Update'
end

When('I add a containing series') do
  create_series edited_contained_series[:series_name]
  fill_in 'Name', with: edited_contained_series[:edit_name]
  click_link 'Add Series'
  click_link 'Select series'
  within '#modal-window' do
    fill_in 'select_search', with: edited_contained_series[:series_search_term]
    find('.search').click #trigger input onchange
    click_button 'Set Series'
  end
  click_link 'Update'
end

When('I return to the series index page') do
  click_link 'Series List'
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

  expect(page).to have_no_link('Add Series')
  expect(page).to have_no_content('Series Index')
end

Then('I should see the series on a display page') do
  expect(page).to have_content(created_series[:name])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the series display page') do
  expect(page).to have_content(edited_series[:edit_name])
  expect(page).to have_content(edited_series[:programs][0][:edit_sequence])
  expect(page).to have_content(edited_series[:programs][1][:edit_sequence])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the contained series display page') do
  expect(page).to have_content(edited_contained_series[:edit_name])
  expect(page).to have_content(edited_contained_series[:series_name])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('the series search still applies') do
  expect(page).to have_content('Series 2')

  expect(page).to have_no_content('Series 1')
end

# HELPER METHODS

def create_series name = default_series[:name]
  Series.create!(name: name)
end

def create_edit_series
  s = create_series edited_series[:original_name]
  p1 = create_program edited_series[:programs][0][:name]
  p2 = create_program edited_series[:programs][1][:name]
  SeriesProgram.create!({
    series_id: s.id,
    program_id: p1.id,
    sequence: edited_series[:programs][0][:original_sequence]
  })
  SeriesProgram.create!({
    series_id: s.id,
    program_id: p1.id,
    sequence: edited_series[:programs][1][:original_sequence]
  })
  s
end