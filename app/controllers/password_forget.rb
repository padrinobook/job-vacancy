require 'timerizer'

JobVacancy::App.controllers :password_forget do
  get :new, :map => '/password_forget' do
    render 'new'
  end

  post :create do
    @user = User.find_by_email(params[:email])

    if @user
      @user.save_forget_password_token
      link = "http://localhost:3000" + url(:password_forget, :edit, :token => @user.password_reset_token)
      deliver(:password_reset, :password_reset_email, @user, link)
    end

    render 'success'
  end

  get :edit, :map => "/password-reset/:token/edit" do
    @user = User.find_by_password_reset_token(params[:token])

    if @user && Time.now < 1.hour.after(@user.password_reset_sent_date)
      render 'edit'
    elsif @user && Time.now >= 1.hour.after(@user.password_reset_sent_date)
      @user.update_attributes({:password_reset_token => 0, :password_reset_sent_date => 0})
      redirect url(:sessions, :new), flash[:error] = 'Password reset token has expired.'
    else
      redirect url(:password_forget, :new)
    end
  end

  post :update, :map => "password-reset/:token" do
    @user = User.find_by_password_reset_token(params[:token])

    if @user && @user.update_attributes(params[:user])
      @user.update_attributes({:password_reset_token => 0, :password_reset_sent_date => 0})
      redirect url(:sessions, :new), flash[:notice] = "Password has been reseted. Please login with your new password."
    else
      render 'edit'
    end
  end
end

