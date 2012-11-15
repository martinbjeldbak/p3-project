require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "register page" do
    before { visit register_path }

    it { should have_selector('h1', text: 'Opret bruger')}
    it { should have_selector('title', text: 'Login eller opret bruger')}
  end

  describe "login page" do

  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "register" do
    before { visit register_path }

    let(:submit) { "Opret konto" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change (User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Navn", with: "Example User"
        fill_in "Email", with: "user@example.dk"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change (User, :count).by(1)
      end
    end
  end
end
