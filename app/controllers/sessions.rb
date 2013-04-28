JobVacancy.controllers :sessions do

  get :new, :map => "/login" do
    render 'sessions/new'
  end

  post :create do
    user = User.find_by_email(params[:email])

    if user && user.confirmation && user.password == params[:password]
      sign_in(user)
      redirect '/'
    else
      render '/sessions/new'
    end
  end

  get :destroy, :map => '/logout' do
    sign_out
    redirect '/'
  end

end
