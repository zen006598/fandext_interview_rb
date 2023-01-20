class ApplicationController < ActionController::Base
  def login(user)
    @current_user = User.find_by(id: user.id)
  end
end
