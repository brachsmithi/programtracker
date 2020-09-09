Given(/^I am on the "(.*?)" page$/) do |do_page|
  visit "/#{do_page.downcase}"
end

Given('I click on the next link') do
  within '.top_pager' do
    click_link 'Next'
  end
end

Given('I click on the show link') do
  click_link 'show'
end

Given('I click on the edit link') do
  click_link 'edit'
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end