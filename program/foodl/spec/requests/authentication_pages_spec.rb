require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_selector('h1',    text: 'Log ind') }
  end
end