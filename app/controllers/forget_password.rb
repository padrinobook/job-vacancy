JobVacancy::App.controllers :forget_password do
  get :new, :map => 'forget_password' do
    render 'new'
  end

  post :create do
    user = User.find_by_email(params[:email])

    if user
      user.save_forget_password_token
      link = "http://localhost:3000" + url(:forget_password, :edit, :token => user.password_reset_token)
      deliver(:password_forget, :password_forget_email, user, link)
    end

    render 'success'
  end

  get :edit, :map => "/password-reset/:token/edit" do
    @user = User.find_by_password_reset_token(params[:token])
    if @user
      render 'edit'
    else
      redirect url(:forget_password, :new)
    end
  end

  post :update, :map => "password-reset/:token" do
    @user = User.find_by_password_reset_token(params[:token])

    if @user.password_reset_sent_date <= Time.now + (60 * 60)
      flash[:error] = "Password has expired"
      redirect url(:forget_password, :new)
    elsif @user.update_attributes(params[:user])
      flash[:notice] = "Password has been reseted. Please login with your new password."
      redirect url(:sessions, :new)
    else
      render 'edit'
    end
  end
end

