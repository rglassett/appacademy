def sign_up_user(username = "testing_username", password = "biscuits")
  visit new_user_url
  fill_in 'Username', with: username
  fill_in 'Password', with: password
  click_on "Create User"
end

def sign_in_user(username = "testing_username", password = "biscuits")
  visit new_session_url
  fill_in 'Username', with: username
  fill_in 'Password', with: password
  click_on "Sign In"
end

def sign_out_user
  click_on "Sign Out"
end