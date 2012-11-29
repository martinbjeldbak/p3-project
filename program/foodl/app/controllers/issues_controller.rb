class IssuesController < ApplicationController
  before_filter :logged_in_user, only: [:index] #:edit, :update
  before_filter :admin_user,     only: [:index]

  def index
    @user = current_user
  end

  #def dead_link
  #  @issue = Issue.new(issue_category: IssueCategory.find_by_name("broken link"),
  #                     user: current_user)
  #end

  def new
    @issue = Issue.new

    @issue.user = current_user

    # issue_category: IssueCategory.find_by_name(params[:name]),

    render partial: 'issues/report_form', layout: false
  end

  def create

  end

  private

  def logged_in_user
    redirect_to login_url, notice: "Log venligst ind." unless logged_in?
  end

  def admin_user
    redirect_to root_path, notice: "Det har du ikke tilladelse til!" unless current_user.admin?
  end
end
