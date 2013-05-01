JobVacancy.controllers :sessions do

  get :new, :map => "/login" do
    render '/sessions/new', :locals => { :error => false }
  end

  post :create do
    user = User.find_by_email(params[:email])

    if user && user.confirmation && user.password == params[:password]
      flash[:notice] = "You have successfully logged in"
      sign_in(user)
      redirect '/'
    else
      render '/sessions/new', :locals => { :error => true }
    end
  end

  get :destroy, :map => '/logout' do
    sign_out
    redirect '/'
  end

end
