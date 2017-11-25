JobVacancy::App.controllers :users do
  before :edit, :update do
    redirect('/login') unless signed_in?
    @user = User.find_by_id(params[:id])
    redirect('/login') unless current_user?(@user)
  end

  get :new, :map => '/register' do
    @user = User.new
    render 'new'
  end

  post :create do
    @user = User.new(params[:user])
    user_completion = UserCompletionMail.new(@user)
    user_completion.encrypt_confirmation_code

    if @user && @user.save
      user_completion.send_registration_mail
      user_completion.send_confirmation_mail
      redirect '/', flash[:notice] = "You have been registered. Please confirm with the mail we've send you recently."
    else
      render 'new'
    end
  end

  get :confirm, :map => '/confirm/:id/:code' do
    @user = User.find_by_id(params[:id])

    if @user && @user.authenticate(params[:code])
      flash[:notice] = "You have been confirmed. Please confirm with the mail we've send you recently."
      render 'confirm'
    else
      redirect '/', flash[:error] = 'Confirmation token is wrong.'
    end
  end

  get :edit, :map => '/users/:id/edit' do
    render 'edit'
  end

  put :update, :map => '/users/:id' do
    route = url(:users, :edit, id: @user.id)
    if @user.update_attributes(params[:user])
      redirect route, flash[:notice] = 'You have updated your profile.'
    else
      redirect route, flash[:error] = 'Your profile was not updated.'
    end
  end
end

