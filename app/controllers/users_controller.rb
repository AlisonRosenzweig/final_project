class UsersController < ApplicationController < Devise::userController
  def new
     super
  end

  def create
    super
  end

  def mark_available
  	@user.available = true
  end

  def mark_unavailable
  	@user = current_user
  	@user.available = false
  end

end
