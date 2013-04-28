JobVacancy.controllers :sessions do

  get :new, :map => "/login" do
    render 'sessions/new'
  end

  post :create do
    user = User.find_by_email(params[:email])

    if user && user.confirmation && user.password == params[:password]
      redirect '/'
    else
      render '/sessions/new'
    end
  end

  delete :destroy do
  end

end
