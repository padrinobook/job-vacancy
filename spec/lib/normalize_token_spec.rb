require 'spec_helper'

RSpec.describe "StringNormalizer" do
  before do
    class StringNormalizerClass
      include StringNormalizer
    end

    @string_normalizer = StringNormalizerClass.new
  end

  it "replaces slashes and + signs in strings" do
    input_string = 'B4+KPW145dG9qjfsBuDhuNLVCG/32etcnEo+j5eAFz4M6/i98KRaZGIJ1K77n/HqePEbD2KFdI3ldIcbiOoazQ=='
    expected_output = 'B4KPW145dG9qjfsBuDhuNLVCG32etcnEoj5eAFz4M6i98KRaZGIJ1K77nHqePEbD2KFdI3ldIcbiOoazQ=='
    expect(@string_normalizer.normalize_token(input_string)).to eq expected_output
  end

end
