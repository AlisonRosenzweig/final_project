class RegistrationsController < Devise::RegistrationsController

	def new_tutor
		build_resource({})
		respond_with self.resource
	end

end
