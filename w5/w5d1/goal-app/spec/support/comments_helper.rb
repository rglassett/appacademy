def create_comment
  click_on "New Comment"
  # save_and_open_page
  fill_in "Comment Text", with: "I'll make a GUI in Visual Basic"
  click_on "Submit Comment"
end