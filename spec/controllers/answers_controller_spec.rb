require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question.id } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    # TODO: how to test that its belongs to question?
    it 'assigns new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer to a database'
      it 'redirects to show view'
    end

    context 'with invalid attributes' do
      it 'does not save an answer'
      it 're-renders new view'
    end
  end
end
