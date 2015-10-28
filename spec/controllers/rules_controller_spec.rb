require 'rails_helper'

RSpec.describe RulesController, type: :controller do
  let(:input) { FactoryGirl.create :input }
  let(:output) { FactoryGirl.create :output }
  let(:valid_attributes) { FactoryGirl.attributes_for(:rule, input_id: input.id, output_id: output.id) }
  let(:invalid_attributes) { { threshold: nil } }

  let(:rule) { FactoryGirl.create :rule }

  describe 'GET #index' do
    it 'assigns all rules as @rules' do
      rule.save
      get :index
      expect(assigns(:rules)).to eq([rule])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested rule as @rule' do
      get :show, id: rule
      expect(assigns(:rule)).to eq(rule)
    end
  end

  describe 'GET #new' do
    it 'assigns a new rule as @rule' do
      get :new
      expect(assigns(:rule)).to be_a_new(Rule)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested rule as @rule' do
      get :edit, id: rule
      expect(assigns(:rule)).to eq(rule)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Rule' do
        expect { post :create, rule: valid_attributes }.to change(Rule, :count).by(1)
      end

      it 'assigns a newly created rule as @rule' do
        post :create, rule: valid_attributes
        expect(assigns(:rule)).to be_a(Rule)
        expect(assigns(:rule)).to be_persisted
      end

      it 'redirects to the created rule' do
        post :create, rule: valid_attributes
        expect(response).to redirect_to(Rule.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved rule as @rule' do
        post :create, rule: invalid_attributes
        expect(assigns(:rule)).to be_a_new(Rule)
      end

      it 're-renders the "new" template' do
        post :create, rule: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { threshold: 1000 } }

      it 'updates the requested rule' do
        put :update, id: rule.to_param, rule: new_attributes
        rule.reload
      end

      it 'assigns the requested rule as @rule' do
        put :update, id: rule.to_param, rule: new_attributes
        expect(assigns(:rule)).to eq(rule)
      end

      it 'redirects to the rule' do
        put :update, id: rule.to_param, rule: new_attributes
        expect(response).to redirect_to(rule)
      end
    end

    context 'with invalid params' do
      it 'assigns the rule as @rule' do
        put :update, id: rule.to_param, rule: invalid_attributes
        expect(assigns(:rule)).to eq(rule)
      end

      it 're-renders the "edit" template' do
        put :update, id: rule.to_param, rule: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      rule.save
    end

    it 'destroys the requested rule' do
      expect { delete :destroy, id: rule }.to change(Rule, :count).by(-1)
    end

    it 'redirects to the rules list' do
      delete :destroy, id: rule
      expect(response).to redirect_to(rules_url)
    end
  end
end
