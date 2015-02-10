class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    unless current_user.nil?
      @mytask_count = Task.where(user_id: current_user.id, completed: false).count
    end
  end
end
