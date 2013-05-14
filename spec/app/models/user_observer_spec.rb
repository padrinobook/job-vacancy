require 'spec_helper'

describe "UserObserver" do
  let(:user) { build(:user)}
  before do
    @observer = UserObserver.instance
    @model = User

  end

  it 'creates Mail::Message object before save' do
    @observer.before_save(user).should be_instance_of(Mail::Message)
  end

  it 'do not create Mail::Message if user already exist' do
    @observer.before_save(@model.first).should be_nil
  end

  it 'creates Mail::Message object after save' do
    @observer.after_save(user).should be_instance_of(Mail::Message)
  end

end

