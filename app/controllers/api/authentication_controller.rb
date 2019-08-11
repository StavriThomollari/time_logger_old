class Api::AuthenticationController < ApplicationController
	
	skip_before_action :verify_authenticity_token


	# POST authenticate
	# return user object and authentication token
	def authenticate
		user, auth_token = AuthenticateUserService.new(authentication_params[:email],
			                                          authentication_params[:password])
																								.authenticate
    
    raise StandardError, "Invalid credentials" and return if !auth_token.present?
    render json: user.as_json(only: :email).merge({ auth_token: auth_token }), status: :ok
  end 

  private

	def authentication_params
  	params.require(:credentials).permit(:email, :password)
	end
end
