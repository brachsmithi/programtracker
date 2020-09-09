Given('there are two pages of programs') do
  (1..16).each do |num|
    Program.create(name: "Program #{num}")
  end
end

Then('I should see the last page') do
  expect(page).to have_no_link('Next')
end