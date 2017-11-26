require 'spec_helper'

RSpec.describe JobVacancy::String::Normalizer do
  let(:normalizer) { Class.new { extend JobVacancy::String::Normalizer } }

  subject { normalizer }

  it 'replaces / and + signs in strings' do
    token = 'B4+K/32'
    expected_token = 'B4K32'
    expect(subject.normalize(token)).to eq expected_token
  end
end

