JobVacancy.helpers do
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:current_user])
  end

  def sign_in(user)
    session[:current_user] = user.id
    self.current_user = user
  end

  def sign_out
    session.delete(:current_user)
  end

  def signed_in?
    !current_user.nil?
  end

end

