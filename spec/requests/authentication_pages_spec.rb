require 'spec_helper'
require 'capybara/rspec'

describe "AuthenticationPages" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('div.login-hd',    text: I18n.t("session.sign_in")) }
    it { should have_selector('title', text: I18n.t("session.sign_in")) }

    describe "with invalid information" do
      before { click_button I18n.t("session.sign_in")}

      it { should have_selector('title', text: I18n.t("session.sign_in")) }
      it { should have_selector('div.alert.alert-error', text: I18n.t("session.flash_error")) }
    
      describe "after visiting another page" do
        before { click_link I18n.t("session.sign_in") }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_link(I18n.t("top_header.profile"), href: user_path(user)) }
      it { should have_link(I18n.t("top_header.sign_out"), href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
      	before { click_link I18n.t("top_header.sign_out") }
      	it { should have_content I18n.t("session.sign_in") }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: I18n.t("session.sign_in")) }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(:controller=>:static_pages,:action=>:admin) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in I18n.t("session.email"), with: user.email
          fill_in I18n.t("session.password"), with: user.password
          click_button I18n.t("session.sign_in")
        end
      end
    end
  end
end
