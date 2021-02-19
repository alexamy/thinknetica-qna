# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #show' do
    let(:answer) { create(:answer, question: question) }

    before { get :show, params: { id: answer } }

    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders a show view' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question.id } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer to a database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }
          .to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to(assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      it 'does not save an answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }
          .not_to change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template(:new)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
