require 'spec_helper'

describe "StaticPages" do
  let(:user) { FactoryGirl.create(:user) }
  before do 
      sign_in user
  end
  
  describe "Admin page" do

    it "should have the content 'Historiske Vestfold'" do
      visit '/static_pages/admin'
      page.should have_content('Tema')
      page.should have_content('Brukere')
      page.should have_content('Nyheter')
    end
  end
end
