def create_goal(description, private_goal=false)
  visit new_goal_url
  fill_in 'Description', with: description
  check("Private") if private_goal
  click_on "Create Goal"
end