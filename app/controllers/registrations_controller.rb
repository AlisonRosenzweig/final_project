class RegistrationsController < Devise::RegistrationsController

	def new_tutor
		build_resource({})
		respond_with self.resource
	end

	def update

		account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

		# "required for settings form to submit when password is left blank"
		if account_update_params[:password].blank?
			account_update_params.delete("password")
			account_update_params.delete("password_confirmation")
		end

		@user = User.find(current_user.id)
		if @user.update_attributes(account_update_params)
			set_flash_message :notice, :updated

	end


end
