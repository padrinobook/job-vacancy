JobVacancy::App.controllers :forget_password do
  get :new, :map => 'forget_password' do
    render 'new'
  end

  post :create do
    user = User.find_by_email(params[:email])

    if user
      user.save_forget_password_token
      deliver(:password_forget, :password_forget_email, user)
    end

    render 'success'
  end

end

