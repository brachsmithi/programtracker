Given('I am on the person index page') do
  visit '/persons'
end

Given('there are {int} pages of persons') do |int|
  create_pages_of_persons int
end

Given('there is one person') do
  create_person
end

Given('I am on the create person page') do
  visit '/persons/new'
end

Given('I am on the edit person page') do
  person = create_edit_person

  visit "/persons/#{person.id}/edit"
end

Given('I have run a person search') do
  create_person 'Person 1'
  create_person 'Person 2'
  visit '/persons'
  run_search 'person 2'
end

Given('I am on page {int} of the person index') do |int|
  visit '/persons'
  within '.top_pager' do
    click_link '2'
  end
  within '.top_pager' do
    expect(page).to have_link('1')
  end
end

When('I click on the new person button') do
  click_link 'New Person'
end

When('I create a person with alias') do
  fill_in 'Name', with: created_person[:name]
  click_link 'Add Alias'
  fill_in 'Alias', with: created_person[:alias]
  click_link 'Create'
end

When('I edit the person') do
  fill_in 'Name', with: edited_person[:edit_name]
  click_link 'Add Alias'
  within '.person_alias:nth-of-type(2)' do
    fill_in 'Alias', with: edited_person[:edit_alias]
  end
  click_link 'Update'
end

When('I return to the person index page') do
  click_link 'Person List'
end

Then('I should see the person page') do
  expect(page).to have_content(default_person[:name])

  expect(page).to have_no_content('Person Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the person edit page') do
  expect(page).to have_content('Edit Person')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Person Index')
end

Then('I should see the new person page') do
  expect(page).to have_content('New Person')
  expect(page).to have_selector(id: 'form')

  expect(page).to have_no_content('Person Index')
end

Then('I should see the person with alias on a display page') do
  expect(page).to have_content(created_person[:name])
  expect(page).to have_content(created_person[:alias])

  expect(page).to have_no_content('Person Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('I should see the changes on the person display page') do
  expect(page).to have_content(edited_person[:edit_name])
  expect(page).to have_content(edited_person[:original_alias])
  expect(page).to have_content(edited_person[:edit_alias])

  expect(page).to have_no_content('Person Index')
  expect(page).to have_no_selector(id: 'form')
end

Then('the person search still applies') do
  expect(page).to have_content('Person 2')

  expect(page).to have_no_content('Person 1')
end

# HELPER METHODS

def create_person name = default_person[:name]
  Person.create!(name: name)
end

def create_edit_person
  per = create_person edited_person[:original_name]
  PersonAlias.create!(person_id: per.id, name: edited_person[:original_alias])
  per
end

def create_pages_of_persons int
  total = int * 15
  (1..total).each do |num|
    create_person "Person #{num}"
  end
end