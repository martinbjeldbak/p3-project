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

    # issue_category: IssueCategory.find_by_name(params[:name]),

    render partial: 'issues/report_form', layout: false
  end

  def create
    @issue_created = Issue.new
    @issue_created.issue_category =  IssueCategory.find_by_id(params[:issue][:issue_category_id])

    if logged_in?
      @issue_created.user = current_user

      if @issue_created.save
        render json: @issue_created
      else
        render json: @issue_created.errors
      end
    else
      render json: true
    end
  end

  private

  def logged_in_user
    redirect_to login_url, notice: "Log venligst ind." unless logged_in?
  end

  def admin_user
    redirect_to root_path, notice: "Det har du ikke tilladelse til!" unless current_user.admin?
  end
end
