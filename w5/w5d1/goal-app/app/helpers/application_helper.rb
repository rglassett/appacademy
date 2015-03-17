module ApplicationHelper

  def auth_token
    html = "<input type='hidden' name='authenticity_token'"
    html += " value='#{form_authenticity_token}' >"
    html.html_safe
  end
end