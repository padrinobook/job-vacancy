JobVacancy::App.controllers :users do
  before :edit, :update  do
    redirect('/login') unless signed_in?
    @user = User.find_by_id(params[:id])
    redirect('/login') unless current_user?(@user)
  end

  get :new, :map => "/register" do
    @user = User.new
    render 'new'
  end

  get :confirm, :map => "/confirm/:id/:code" do
    @user = User.find_by_id(params[:id])

    if @user && @user.authenticate(params[:code])
      flash[:notice] = "You have been confirmed. Please confirm with the mail we've send you recently."
      render 'confirm'
    else
      flash[:error] = "Confirmed code is wrong."
      redirect('/')
    end
  end

  get :edit, :map => '/users/:id/edit' do
    @user = User.find_by_id(params[:id])
    render 'edit'
  end

  put :update, :map => '/users/:id' do
    @user = User.find_by_id(params[:id])

    unless @user
      flash[:error] = "User is not registered in our platform."
      render 'edit'
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = "You have updated your profile."
      render 'edit'
    else
      flash[:error] = "Your profile was not updated."
      render 'edit'
    end
  end

  post :create do
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "You have been registered. Please confirm with the mail we've send you recently."
      redirect('/')
    else
      render 'new'
    end
  end
end

