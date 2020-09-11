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

When('I click on the new program version cluster button') do
  click_link 'New Cluster'
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