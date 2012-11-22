class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  helper_method :firebug
  helper_method :num_favorites

  def num_favorites
    if !current_user
      return 0
    end
    current_user.favorites.size
  end

  private
  def firebug(message, type = :debug)
    request.env['firebug.logs'] ||= []
    request.env['firebug.logs'] << [type.to_sym, message.to_s]
  end
end
