module RequestHelper

  def self.auth_headers(user)
    user, auth_token = AuthenticateUserService.new(user.email, user.password).authenticate
    {
        'Authorization': auth_token.to_s
    }
  end
end