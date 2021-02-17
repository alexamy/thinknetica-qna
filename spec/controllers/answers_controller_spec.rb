# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 3, question: question) }

    before { get :index, params: { question_id: question.id } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders index view' do
      expect(response).to render_template(:index)
    end
  end
end
