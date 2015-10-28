require 'rails_helper'

RSpec.describe PortsController, type: :controller do
  let(:valid_attributes) { FactoryGirl.attributes_for(:input) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:input).merge(number: nil) }
  let(:location) { FactoryGirl.create(:location) }
  let(:port) { FactoryGirl.create(:input) }

  describe 'GET #index' do
    it 'assigns all ports as @ports' do
      port.save
      get :index, location_id: location
      expect(assigns(:ports)).to eq([port])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested port as @port' do
      port.save
      get :show, id: port
      expect(assigns(:port)).to eq(port)
    end
  end

  describe 'GET #new' do
    it 'assigns a new port as @port' do
      get :new, location_id: location
      expect(assigns(:port)).to be_a_new(Port)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested port as @port' do
      port.save
      get :edit, id: port
      expect(assigns(:port)).to eq(port)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Port' do
        expect { post :create, location_id: location, port: valid_attributes }.to change(Port, :count).by(1)
      end

      it 'assigns a newly created port as @port' do
        post :create, location_id: location, port: valid_attributes
        expect(assigns(:port)).to be_a(Input)
        expect(assigns(:port)).to be_persisted
      end

      it 'redirects to the created port' do
        post :create, location_id: location, port: valid_attributes
        expect(response).to redirect_to(Port.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved port as @port' do
        post :create, location_id: location, port: invalid_attributes
        expect(assigns(:port)).to be_a_new(Input)
      end

      it 're-renders the "new" template' do
        post :create, location_id: location, port: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'swag 17' } }

      it 'updates the requested port' do
        put :update, id: port, port: new_attributes
        port.reload
        expect(port.name).to eq('swag 17')
      end

      it 'assigns the requested port as @port' do
        put :update, id: port, port: new_attributes
        expect(assigns(:port)).to eq(port)
      end

      it 'redirects to the port' do
        put :update, id: port, port: new_attributes
        expect(response).to redirect_to(port)
      end
    end

    context 'with invalid params' do
      it 'assigns the port as @port' do
        put :update, id: port, port: invalid_attributes
        expect(assigns(:port)).to eq(port)
      end

      it 're-renders the "edit" template' do
        put :update, id: port, port: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested port' do
      port.save
      expect { delete :destroy, id: port }.to change(Port, :count).by(-1)
    end

    it 'redirects to the ports list' do
      delete :destroy, id: port
      expect(response).to redirect_to(location_ports_url(port.location))
    end
  end
end
