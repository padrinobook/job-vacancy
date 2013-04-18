JobVacancy.controllers :users do

  get :new, :map => "/login" do
    @user = User.new
    render 'users/new'
  end

  post :create do
    @user = User.new(params[:user])

    if @user.save
      deliver(:registration, :registration_email, @user.name, @user.email)
      redirect('/')
    else
      render 'users/new'
    end
  end
end
