require 'spec_helper'

RSpec.describe "/users" do
  describe "GET new" do
    it "render the :new view" do
      get "/register"
      expect(last_response).to be_ok
    end
  end

  describe "GET confirm" do
    let(:user) { build(:user) }
    it "render the '/confirm' page if user has confirmation code" do
      get "/confirm/#{user.id}/#{user.confirmation_token}"
      expect(last_response).to be_ok
    end

    it 'redirect to :confirm if user id is wrong' do
      get "/confirm/test/#{user.confirmation_token}"
      expect(last_response).to be_redirect
      expect(last_response.body).to include("Confirmation code is wrong.")
    end

    it 'redirect to :confirm if confirmation id is wrong' do
      get "/confirm/#{user.id}/test"
      expect(last_response).to be_redirect
      expect(last_response.body).to include("Confirmation code is wrong.")
    end
  end

  describe "GET /users/:id/edit" do
    let(:user) { build(:user) }
    let(:user_second) { build(:user) }

    it 'redirects to /login if user is not signed in' do
      expect(User).to receive(:find_by_id).and_return(nil)
      get '/users/-1/edit'
      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/login')
    end

    it 'redirects to /login signed in user tries to call a different user' do
      expect(User).to receive(:find_by_id).and_return(user, user_second)
      get "/users/#{user_second.id}/edit"
      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/login')
    end

    it 'renders the view for editing a user' do
      expect(User).to receive(:find_by_id).and_return(user, user)
      get "/users/#{user.id}/edit", {}, 'rack.session' => { current_user: user_second }
      expect(last_response).to be_ok
      expect(last_response.body).to include('Edit your profile')
    end
  end

  describe "PUT /users/:id" do
    let(:user) { build(:user) }
    let(:user_second) { build(:user) }
    let(:put_user) {
      {'name' => user.name,
       'email' => user.email,
       'password' => user.password,
       'password_confirmation' => user.password
      }
    }

    describe "redirects to /login if" do
      it 'user is not signed in' do
        expect(User).to receive(:find_by_id).and_return(nil)
        put '/users/1'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end

      it "user is signed in and tries to call a different user" do
        expect(User).to receive(:find_by_id).and_return(user, user_second)
        put "/users/1"
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end
    end

    describe "link to /edit" do
      it 'if user has valid account changes' do
        test_user = double(User, id: user.id)
        expect(test_user).to receive(:update_attributes).with(put_user) { true }
        expect(User).to receive(:find_by_id).and_return(test_user, test_user)

        put "/users/#{user.id}", user: put_user
        expect(last_response).to be_redirect
        expect(last_response.body).to eq 'You have updated your profile.'
        expect(last_response.header['Location']).to include('/edit')
      end

      it 'if user has not valid account changes' do
        put_user =
          {'name' => user.name,
           'email' => user.email,
           'password' => user.password,
           'password_confirmation' => 'fake'
          }

        test_user = double(User, id: user.id)
        expect(test_user).to receive(:update_attributes).with(put_user) { false }
        expect(User).to receive(:find_by_id).and_return(test_user, test_user)

        put "/users/#{user.id}", user: put_user
        expect(last_response).to be_redirect
        expect(last_response.body).to eq 'Your profile was not updated.'
        expect(last_response.header['Location']).to include('/edit')
      end
    end
  end

  describe "POST /users/create" do
    let(:user) { build(:user) }

    before do
      @completion_user_mail = UserCompletionMail
      expect(User).to receive(:new).and_return(user)
      expect(@completion_user_mail).to receive(:encrypt_confirmation_code)
    end

    it 'redirects to home if user can be saved' do
      expect(user).to receive(:save).and_return(true)
      expect(UserCompletionMail).to receive(:new).with(user).and_return(@completion_user_mail)
      expect(@completion_user_mail).to receive(:send_registration_mail)
      expect(@completion_user_mail).to receive(:send_confirmation_mail)
      post "/users/create"
      expect(last_response).to be_redirect
      expect(last_response.body).to eq "You have been registered. Please confirm with the mail we've send you recently."
    end

    it 'renders registration page if user cannot be saved' do
      expect(UserCompletionMail).to receive(:new).with(user).and_return(@completion_user_mail)
      expect(user).to receive(:save).and_return(false)
      post "/users/create"
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Registration'
    end
  end
end
