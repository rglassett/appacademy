require 'rails_helper'

feature "CRUDing goals" do
  before(:each) do
    sign_up_user
  end
  
  it "has a new goal form" do
    visit new_goal_url
    expect(page).to have_content "New Goal"
    expect(page).to have_content "Description"
    expect(page).to have_content "Private"
    expect(page).to have_button "Create Goal"
  end

  it "can create new goals" do
    create_goal("earn ALL the money")
    visit user_url(User.first)
    # save_and_open_page
    expect(page).to have_content("earn ALL the money")
  end
  
  it "shows a list of a user's goals" do
    create_goal("earn ALL the money")
    create_goal("finish appacademy")
    
    visit user_url(User.first)
    
    expect(page).to have_content("earn ALL the money")
    expect(page).to have_content("finish appacademy")
  end
  
  feature "private goals" do
    before(:each) do
      create_goal("pioneer net neutrality", true)
      create_goal("share too much information", false)
    end
    
    it "shows the current user's private goals" do
      visit user_url(User.first)
    
      expect(page).to have_content("pioneer net neutrality")
    end
    
    it "shows other user's public goals" do
      sign_up_user("hank", "password")
      
      visit user_url(User.first)
      
      expect(page).to have_content("share too much information")
    end
  
    feature "does not show other users' private goals" do
      before(:each) do
        sign_out_user
      end
      
      it "when not signed in" do
        visit user_url(User.first)
      
        expect(page).not_to have_content("pioneer net neutrality")
      end
      
      it "when signed in as someone else" do
        sign_up_user("hank", "password")
        
        visit user_url(User.first)
      
        expect(page).not_to have_content("pioneer net neutrality")
      end
    end
  end
  
  feature "can edit existing goals" do
    before(:each) do
      create_goal("finish something")
    end
    
    it "has an edit form" do
      visit edit_goal_url(Goal.find_by(description: "finish something"))
      expect(page).to have_content "Edit Goal"
      expect(page).to have_content "Description"
      expect(page).to have_content "Private"
      expect(page).to have_button "Update Goal"
    end
    
    it "updates goal descriptions" do
      visit edit_goal_url(Goal.find_by(description: "finish something"))
      fill_in "Description", with: "acquire currency"
      click_on("Update Goal")
      expect(page).to have_content "acquire currency"
    end
    
    it "allows users to mark goals as completed" do
      visit edit_goal_url(Goal.find_by(description: "finish something"))
      check("Completed")
      click_on("Update Goal")

      expect(page).to have_content("Completed")
    end
    
  end
  
  it "can delete existing goals" do
    create_goal("finish something")
    visit goal_url(Goal.find_by(description: "finish something"))
    click_on("Delete Goal")
    expect(page).to_not have_content "finish something"
  end

end