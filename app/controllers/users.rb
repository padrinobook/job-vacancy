JobVacancy.controllers :users do
  get :new, :map => "/register" do
    @user = User.new
    render 'users/new'
  end

  get :confirm, :map => "/confirm/:id/:code" do
    @user = User.find_by_id(params[:id])
    if (@user &&  @user.authenticate(params[:code]))
      flash[:notice] = "You have been confirmed. Please confirm with the mail we've send you recently."
      render 'users/confirm'
    else
      flash[:error] = "Confirmed code is wrong."
      redirect('/')
    end
  end

  # using namespaced route alias
  get :edit, :map => '/users/:id/edit' do
    @user = User.find_by_id(params[:id])
    unless @user
      redirect('/')
    end
    render 'users/edit'
  end

  put :update, :map => '/users/:id' do
    @user = User.find(params[:id])

    unless @user
      render 'users/edit'
    end

    if @user.update_attributes(params[:user])
      # make flash message
      redirect('/')
    end
  end

  post :create do
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "You have been registered. Please confirm with the mail we've send you recently."
      redirect('/')
    else
      render 'users/new'
    end
  end


end
