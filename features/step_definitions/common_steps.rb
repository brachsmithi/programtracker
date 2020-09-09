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

When('I click on the edit link') do
  click_link 'edit'
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end