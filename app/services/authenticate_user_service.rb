class AuthenticateUserService
	def initialize(email, password)
		@email = email
		@password = password
	end

	def authenticate
		return user, JsonWebToken.new.encode(user_id: user.id) if user
	end

	private

	def user
		user = User.find_by_email(@email)
		return user if user && user.valid_password?(@password)
		nil
	end
end
