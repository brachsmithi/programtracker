Given(/^I am on the "(.*?)" page$/) do |do_page|
  visit "/#{do_page.downcase}"
end

When('I click on the next link') do
  within '.top_pager' do
    click_link 'Next'
  end
end

When('I click on the show link') do
  click_link 'show'
end

When('I click on the delete link') do
  page.accept_confirm do
    click_link 'destroy'
  end
end

When('I save the changes') do
  click_link 'Update'
end

When('I click on the edit link') do
  click_link 'edit'
end

When('I run a search') do
  run_search '9'
end

When('I cancel out') do
  click_link 'Cancel'
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then('I should see the last page') do
  expect(page).to have_no_link('Next')
end

Then('the index page is empty') do
  expect(page).to have_no_link 'show'
  expect(page).to have_no_content 'Exception'
end

Then('there are less than {int} pages on {string} page') do |int, string|
  expect(page).to have_content(string)
  expect(page).to have_link('show')
  
  expect(page).to have_no_link(int.to_s)
end

# HELPER METHODS

def run_search search_term = '9'
  fill_in 'search', with: search_term
  find('#search').native.send_keys(:return)
end