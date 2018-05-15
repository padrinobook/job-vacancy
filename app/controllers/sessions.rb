require 'securerandom'

JobVacancy::App.controllers :sessions do
  get :new, :map => "/login" do
    render 'new', :locals => { :error => false }
  end

  post :create do
    @user = User.find_by_email(params[:email])

    if @user && @user.confirmation && @user.password == params[:password]
      if (params[:remember_me] == '1')
        token = SecureRandom.hex
        @user.authentity_token = token
        thirty_days = JobVacancy::Configuration::COOKIE_MAX_DAYS_REMEMBER_ME
        response.set_cookie('permanent_cookie', {
                              value: 1,
                              expires: (Date.today + thirty_days).to_time,
                              domain: 'jobvacancy.de',
                              path: '/',
                              httponly: true,
                              secure: false,
                            })
        @user.save
      end

      sign_in(@user)
      redirect '/', flash[:notice] = 'You have successfully logged in!'
    else
      render 'new', locals: { error: true }
    end
  end

  delete :destroy, :map => '/logout' do
    sign_out
    redirect '/', flash[:notice] = 'You have successfully logged out.'
  end
end

