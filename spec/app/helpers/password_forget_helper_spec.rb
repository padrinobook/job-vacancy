require 'spec_helper'

RSpec.describe JobVacancy::App::ForgetPasswordHelper do
  xit "add some examples to (or delete) #{__FILE__}" do
    let(:helpers) { Class.new }
    before { helpers.extend JobVacancy::App::PasswordForgetHelper }
    subject { helpers }

    it 'should return nil' do
      expect(subject.foo).to be_nil
    end
  end
end
