require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_selector('h1',    text: 'Log ind') }
  end

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Log ind" }

      it { should have_selector('title', text: 'Log ind') }
      it { should have_selector('div.alert.alert-error', text: 'Forkert') }

      describe "after visiting another page" do
        before { click_link root_path }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
end