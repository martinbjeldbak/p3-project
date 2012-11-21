require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "register page" do
    before { visit register_path }

    it { should have_selector('h1', text: 'Opret bruger')}
  end

  describe "login page" do

  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',    text: "Opdater profil") }
      it { should have_selector('title', text: "Redigér bruger") }
    end

    describe "with invalid information" do
      before { click_button "Gem ændringer" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "Ny navn" }
      let(:new_email) { "ny@example.dk" }
      before do
        fill_in "Email",            with: new_email
        fill_in "Kodeord",         with: user.password
        fill_in "Bekræft kodeord", with: user.password
        click_button "Gem ændringer"
      end

      #it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Log ud', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
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
