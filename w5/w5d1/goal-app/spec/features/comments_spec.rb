require 'rails_helper'

feature "comments" do
  before(:each) { sign_up_user }
  
  feature "allows comments on goals" do
    before(:each) do
      create_goal "Don't crash the server"
    end
    
    feature "allows new comments" do
  
      it "has a new comment form" do
        expect(page).to have_button("New Comment")
        click_on("New Comment")
        expect(page).to have_button("Submit Comment")
      end

      it "shows new comments after posting" do
        create_comment
        expect(page).to have_content("I'll make a GUI in Visual Basic")
      end
      
    end
    
    feature "allows editing comments" do
      before(:each) { create_comment }
   
      it "has an edit comment form" do
        expect(page).to have_button("Edit Comment")
        click_on("Edit Comment")
        expect(page).to have_button("Update Comment")
      end
  
      it "shows the edited comment after updating" do
        click_on("Edit Comment")
        fill_in "Comment Text", with: "I've been edited!"
        expect(page).to have_content("I've been edited!")
      end
  
    end
  
    it "allows comments to be deleted" do
      create_comment
      expect(page).to have_button("Delete Comment")
      click_on("Delete Comment")
      expect(page).not_to have_content("I'll make a GUI in Visual Basic")
    end
    
  end
  
  feature "allows comments on users" do
  
    feature "allows new comments" do

      it "has a new comment form" do
        expect(page).to have_button("New Comment")
        click_on("New Comment")
        expect(page).to have_button("Submit Comment")
      end

      it "shows new comments after posting" do
        create_comment
        expect(page).to have_content("I'll make a GUI in Visual Basic")
      end
    
    end
  
    feature "allows editing comments" do
      before(:each) { create_comment }
 
      it "has an edit comment form" do
        expect(page).to have_button("Edit Comment")
        click_on("Edit Comment")
        expect(page).to have_button("Update Comment")
      end

      it "shows the edited comment after updating" do
        click_on("Edit Comment")
        fill_in "Comment Text", with: "I've been edited!"
        expect(page).to have_content("I've been edited!")
      end

    end

    it "allows comments to be deleted" do
      create_comment
      expect(page).to have_button("Delete Comment")
      click_on("Delete Comment")
      expect(page).not_to have_content("I'll make a GUI in Visual Basic")
    end
    
  end
end
