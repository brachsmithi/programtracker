Given('I am on the director index page') do
  visit '/directors'
end

Given('there are {int} pages of directors') do |int|
  create_pages_of_directors int
end

Given('there is one director') do
  create_director
end

Given('I am on the create director page') do
  visit '/directors/new'
end

Given('I am on the edit director page') do
  director = create_edit_director

  visit "/directors/#{director.id}/edit"
end

Given('I have run a director search') do
  create_director 'Director 1'
  create_director 'Director 2'
  visit '/directors'
  run_search 'director 2'
end

Given('I am on page {int} of the director index') do |int|
  visit '/directors'
  within '.top_pager' do
    click_link '2'
  end
  within '.top_pager' do
    expect(page).to have_link('1')
  end
end

When('I click on the new director button') do
  click_link 'New Director'
end

When('I create a director with alias') do
  fill_in 'Name', with: created_director[:name]
  click_link 'Add Alias'
  fill_in 'Alias', with: created_director[:alias]
  click_link 'Create'
end

When('I edit the director') do
  fill_in 'Name', with: edited_director[:edit_name]
  click_link 'Add Alias'
  within '.person_alias:nth-of-type(2)' do
    fill_in 'Alias', with: edited_director[:edit_alias]
  end
  click_link 'Update'
end

When('I return to the director index page') do
  click_link 'Director List'
end

Then('I should see the director page') do
  expect(page).to have_content(default_director[:name])

  expect(page).to have_no_content('Director Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the director edit page') do
  expect(page).to have_content('Edit Director')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Director Index')
end

Then('I should see the new director page') do
  expect(page).to have_content('New Director')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Director Index')
end

Then('I should see the director with alias on a display page') do
  expect(page).to have_content(created_director[:name])
  expect(page).to have_content(created_director[:alias])

  expect(page).to have_no_content('Director Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the director display page') do
  expect(page).to have_content(edited_director[:edit_name])
  expect(page).to have_content(edited_director[:original_alias])
  expect(page).to have_content(edited_director[:edit_alias])

  expect(page).to have_no_content('Director Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('the director search still applies') do
  expect(page).to have_content('Director 2')

  expect(page).to have_no_content('Director 1')
end

# HELPER METHODS

def create_director name = default_director[:name]
  Director.create!(name: name)
end

def create_edit_director
  d = create_director edited_director[:original_name]
  PersonAlias.create!(director_id: d.id, name: edited_director[:original_alias])
  d
end

def create_pages_of_directors int
  total = int * 15
  (1..total).each do |num|
    create_director "Director #{num}"
  end
end