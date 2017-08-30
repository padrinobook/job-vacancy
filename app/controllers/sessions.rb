JobVacancy::App.controllers :sessions do
  get :new, :map => "/login" do
    render 'new', :locals => { :error => false }
  end

  post :create do
    @user = User.find_by_email(params[:email])

    if @user && @user.confirmation && @user.password == params[:password]
      if (params[:remember_me] == "true")
        require 'securerandom'
        token = SecureRandom.hex
        @user.authentity_token = token
        thirty_days_in_seconds = JobVacancy::Configuration::COOKIE_MAX_AGE_REMEMBER_ME
        response.set_cookie('permanent_cookie',
                            value: { domain: 'jobvacancy.de',
                                        path: '/' },
                                        max_age: "#{thirty_days_in_seconds}")
        @user.save
      end

      flash[:notice] = 'You have successfully logged in!'
      sign_in(@user)
      redirect '/'
    else
      render 'new', locals: { error: true }
    end
  end

  get :destroy, :map => '/logout' do
    sign_out
    flash[:notice] = 'You have successfully logged out.'
    redirect '/'
  end
end

