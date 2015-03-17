require 'rails_helper'

feature "the signup process" do 

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  feature "signing up a user" do
    # before(:each) { sign_up_user }
    
    it "shows username on the homepage after signup" do
      sign_up_user
      # visit root_url
      expect(page).to have_content "testing_username"
    end
  end

end

feature "logging in" do 
  before(:each) do 
    sign_up_user
    sign_out_user
    sign_in_user
  end
   
  it "shows username on the homepage after login" do
    visit root_url
    expect(page).to have_content "testing_username"
  end  
end

feature "logging out" do 

  it "begins with logged out state" do
    visit root_url
    expect(page).to_not have_button('Sign Out')
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_user
    sign_out_user
    expect(page).to_not have_content('testing_username')
  end

end
