class TutorStatusesController < ApplicationController

def mark_available
	@user = current_user
  	@user.available = true
  	redirect_to '/'
end

def mark_unavailable
	@user = current_user
  	@user.available = false
  	redirect_to '/'
end

end
