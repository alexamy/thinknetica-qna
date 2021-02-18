require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new }

    it 'assigns requested question to @question'
    it 'assigns new answer to @answer'
    it 'renders new view'
  end
end
