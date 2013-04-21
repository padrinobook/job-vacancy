JobVacancy.controllers :users do

  get :new, :map => "/login" do
    @user = User.new
    render 'users/new'
  end

  get :confirm, :map => "/confirm/:id/:code" do
    redirect('/') unless @user = User.find_by_id(params[:id])
    redirect('/') unless @user.authenticate(params[:code])
    render 'users/confirm'
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
