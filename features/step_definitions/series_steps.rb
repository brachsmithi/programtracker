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

Given('I am on the edit series page for a wrapper series') do
  series = create_edit_wrapper_series

  visit "/series/#{series.id}/edit"
end

Given('I am on the edit page of a series that has content') do
  series = create_edit_series_for_deletion

  visit "/series/#{series.id}/edit"
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
  within '.series_capsule:nth-of-type(1)' do
    fill_in 'Sequence', with: edited_series[:disc][:edit_sequence]
  end
  within '.series_capsule:nth-of-type(2)' do
    fill_in 'Sequence', with: edited_series[:programs][0][:edit_sequence]
  end
  within '.series_capsule:nth-of-type(3)' do
    fill_in 'Sequence', with: edited_series[:programs][1][:edit_sequence]
  end
  click_link 'Update'
end

When('I add a containing series') do
  create_series edited_contained_series[:series_name]
  fill_in 'Name', with: edited_contained_series[:edit_name]
  click_link 'Add Wrapper Series'
  click_link 'Select series'
  within '#modal-window' do
    fill_in 'select_search', with: edited_contained_series[:series_search_term]
    find('.search').click #trigger input onchange
    click_button 'Set Series'
  end
  click_link 'Update'
end

When('I edit the sequence of the contained series') do
  fill_in 'Name', with: edited_wrapper_series[:edit_name]
  within '.series_capsule:nth-of-type(1)' do
    fill_in 'Sequence', with: edited_wrapper_series[:edit_sequence]
  end
  click_link 'Update'
end

When('I return to the series index page') do
  click_link 'Series List'
end

When('I delete the series content and save') do
  within '.series_capsule:nth-of-type(3)' do
    find('.remove_fields').click
  end
  within '.series_capsule:nth-of-type(2)' do
    find('.remove_fields').click
  end
  within '.series_capsule:nth-of-type(1)' do    
    find('.remove_fields').click
  end
  click_link 'Update'
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
  expect(page).to have_content(edited_series[:disc][:edit_sequence])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the contained series display page') do
  expect(page).to have_content(edited_contained_series[:edit_name])
  expect(page).to have_content(edited_contained_series[:series_name])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the wrapper series display page') do
  expect(page).to have_content(edited_wrapper_series[:edit_name])
  expect(page).to have_content(edited_wrapper_series[:edit_sequence])

  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('the series search still applies') do
  expect(page).to have_content('Series 2')

  expect(page).to have_no_content('Series 1')
end

Then('I should see that the series is empty') do
  expect(page).to have_content(edited_series_for_deletion[:series_name])

  expect(page).to have_no_content(edited_series_for_deletion[:contained_series_name])
  expect(page).to have_no_content(edited_series_for_deletion[:program_name])
  expect(page).to have_no_content(edited_series_for_deletion[:disc_name])
  expect(page).to have_no_content('Series Index')
  expect(page).to have_no_selector(id: 'form')
end

# HELPER METHODS

def create_series name = default_series[:name]
  Series.create!(name: name)
end

def create_edit_series
  s = create_series edited_series[:original_name]
  p1 = create_program edited_series[:programs][0][:name]
  p2 = create_program edited_series[:programs][1][:name]
  d = create_disc edited_series[:disc][:name]
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
  SeriesDisc.create!({
    series_id: s.id,
    disc_id: d.id,
    sequence: edited_series[:disc][:original_sequence]
  })
  s
end

def create_edit_wrapper_series
  ws = create_series edited_wrapper_series[:original_name]
  cs = create_series edited_wrapper_series[:contained_series_name]
  SeriesSeries.create!({
    wrapper_series: ws, 
    contained_series: cs, 
    sequence: edited_wrapper_series[:original_sequence]
  })
  ws
end

def create_edit_series_for_deletion
  ws = create_series edited_series_for_deletion[:series_name]
  cs = create_series edited_series_for_deletion[:contained_series_name]
  p = create_program edited_series_for_deletion[:program_name]
  d = create_disc edited_series_for_deletion[:disc_name]
  SeriesSeries.create!({
    wrapper_series: ws, 
    contained_series: cs, 
    sequence: edited_series_for_deletion[:series_sequence]
  })
  SeriesProgram.create!({
    series: ws,
    program: p,
    sequence: edited_series_for_deletion[:program_sequence]
  })
  SeriesDisc.create!({
    series: ws,
    disc: d,
    sequence: edited_series_for_deletion[:disc_sequence]
  })
  ws
end