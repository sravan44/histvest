include ApplicationHelper

def sign_in(user)
  #visit signin_path
  #fill_in I18n.t("session.email"),    with: user.email
  #fill_in I18n.t("session.password"), with: user.password
  #click_button I18n.t("session.sign_in")
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end