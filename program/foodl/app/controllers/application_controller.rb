class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  helper_method :firebug
  private
  def firebug(message, type = :debug)
    request.env['firebug.logs'] ||= []
    request.env['firebug.logs'] << [type.to_sym, message.to_s]
  end
end
