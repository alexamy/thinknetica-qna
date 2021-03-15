# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, author: user) }
  let!(:answer) { create(:answer, question: question, author: user) }
  let!(:answer_with_files) { create(:answer, :with_files, question: question, author: user) }

  let!(:other_user) { create(:user) }
  let!(:other_question) { create(:question, author: other_user) }
  let!(:other_answer) { create(:answer, question: other_question, author: other_user) }

  describe 'GET #show' do
    before { get :show, params: { id: answer } }

    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders a show view' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    before { login(user) }

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
    before { login(user) }

    context 'with valid attributes' do
      it 'assigns user to @user' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js }
        expect(assigns(:user)).to be_an_instance_of(User)
      end

      it 'saves a new answer to a database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js } }
          .to change(question.answers, :count).by(1)
      end

      it 'renders create view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save an answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid), format: :js } }
          .not_to change(Answer, :count)
      end

      it 'renders create view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    it "can't update other user answer" do
      expect do
        patch :update, params: { id: other_answer.id, answer: { body: 'new body' }, format: :js }
        other_answer.reload
      end.not_to change(other_answer, :body)
    end

    it 'renders update view' do
      patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
      expect(response).to render_template :update
    end

    context 'with valid attributes' do
      it 'assigns user to @user' do
        patch :update, params: { id: answer.id, answer: attributes_for(:answer), format: :js }
        expect(assigns(:user)).to be_an_instance_of(User)
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer.id, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'joins file collections' do
        files = [create_file('spec/spec_helper.rb')]
        expect do
          patch :update, params: { id: answer_with_files.id, answer: { files: files } }, format: :js
        end.to change(answer_with_files.files, :count).by 1
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer.id, answer: attributes_for(:answer, :invalid) }, format: :js
        end.not_to change(answer, :body)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end

    it 'deletes the best answer' do
      answer.set_as_best
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end

    it "can't delete other's answer" do
      expect { delete :destroy, params: { id: other_answer }, format: :js }.not_to change(Answer, :count)
    end
  end

  describe 'POST #set_as_best' do
    before { login(user) }

    it 'sets the answer as best' do
      post :set_as_best, params: { id: answer.id }, format: :js
      answer.question.reload
      expect(answer.question.best_answer).to eq answer
    end

    it 'allows to set an answer as best only for author of the question' do
      expect do
        post :set_as_best, params: { id: other_answer.id }, format: :js
        other_answer.question.reload
      end.not_to change(other_answer.question, :best_answer)
    end

    it 'render set_as_best view' do
      post :set_as_best, params: { id: answer.id }, format: :js
      expect(response).to render_template :set_as_best
    end
  end
end
