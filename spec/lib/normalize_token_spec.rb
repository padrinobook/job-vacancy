require 'spec_helper'

RSpec.describe StringNormalizer do
  let(:string_normalizer) { Class.new { extend StringNormalizer } }

  subject { string_normalizer }

  it 'replaces slashes and + signs in strings' do
    token = 'B4+K/32'
    expected_token = 'B4K32'
    expect(subject.normalize(token)).to eq expected_token
  end
end

