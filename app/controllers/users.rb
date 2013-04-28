JobVacancy.controllers :users do

  get :new, :map => "/register" do
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
      redirect('/')
    else
      render 'users/new'
    end
  end

end
