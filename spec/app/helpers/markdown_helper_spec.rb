require 'spec_helper'

RSpec.describe JobVacancy::App::MarkdownHelper do
  let(:user) { User.new }
  let(:markdown_helper) { Class.new.extend JobVacancy::App::MarkdownHelper}

  subject { markdown_helper }

  describe "#markdown" do
    it 'renders html' do
      expected_result = "<h1>Hallo</h1>\n"
      text_to_render = "# Hallo"
      expect(subject.markdown(text_to_render)).to eq expected_result
    end
  end
end

