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