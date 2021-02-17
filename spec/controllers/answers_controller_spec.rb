# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    before { get :index }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'populates array fo all answers'
    it 'renders index view'
  end
end
