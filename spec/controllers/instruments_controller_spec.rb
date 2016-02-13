require 'rails_helper'
include LoginMacros

describe InstrumentsController do

  let(:instrument) { create(:instrument) }
  let(:valid_attributes) { attributes_for(:instrument) }
  let(:invalid_attributes) { attributes_for(:invalid_instrument) }

  shared_examples 'read instrument' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 instruments' do
        instrument_0 = create_list(:instrument, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:instruments).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:instrument) { create(:instrument) }

      before :each do
        get :show, id: instrument
      end

      it "assigns the requested instrument to @instrument" do
        expect(assigns(:instrument)).to eq instrument
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create instrument' do
    describe 'GET #new' do
      it "assigns a new instrument to @instrument" do
        get :new
        expect(assigns(:instrument)).to be_a_new(Instrument)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new instrument in the database" do
          expect{
            post :create, instrument: attributes_for(:instrument)
          }.to change(Instrument, :count).by(1)
        end

        it "redirects to instrument#show" do
          post :create, instrument: attributes_for(:instrument)
          expect(response).to redirect_to instrument_path(assigns[:instrument])
        end
      end

      context "with invalid attributes" do
        it "does not save the new instrument in the database" do
          expect{
            post :create,
              instrument: attributes_for(:invalid_instrument)
          }.not_to change(Instrument, :count)
        end

        it "re-renders the :new template" do
          post :create,
            instrument: attributes_for(:invalid_instrument)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit instrument' do

    describe 'GET #edit' do
      it "assigns the requested instrument to @instrument" do
        instrument = create(:instrument)
        get :edit, id: instrument
        expect(assigns(:instrument)).to eq instrument
      end

      it "renders the :edit template" do
        instrument = create(:instrument)
        get :edit, id: instrument
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @instrument = create(:instrument)
      end

      context "valid attributes" do
        it "locates the requested @instrument" do
          allow(instrument).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @instrument,
            instrument: attributes_for(:instrument)
          expect(assigns(:instrument)).to eq @instrument
        end

        it "changes the instrument's attributes" do
          patch :update, id: @instrument,
            instrument: attributes_for(:instrument,
              title: 'Hello world!'
            )
          @instrument.reload
          expect(@instrument.title).to eq 'Hello world!'
        end

        it "redirects to the updated instrument" do
          patch :update, id: @instrument, instrument: attributes_for(:instrument)
          expect(response).to redirect_to @instrument
        end
      end

      context "invalid attributes" do
        before :each do
          allow(instrument).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: instrument, instrument: invalid_attributes
        end

        it "locates the requested @instrument" do
          expect(assigns(:instrument)).to eq instrument
        end

        it "does not change the instrument's attributes" do
          expect(assigns(:instrument).reload.title).to eq instrument.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete instrument' do

    describe 'DELETE #destroy' do
      before :each do
        @instrument = create(:instrument)
      end

      it "deletes the instrument" do
        expect{
          delete :destroy, id: @instrument
        }.to change(Instrument,:count).by(-1)
      end

      it "redirects to instrument#index" do
        delete :destroy, id: @instrument
        expect(response).to redirect_to instruments_url
      end
    end
  end

  describe "user with full permission to instrument" do
    before :each do
      sign_in
    end

    it_behaves_like 'read instrument'
    it_behaves_like 'create instrument'
    it_behaves_like 'edit instrument'
    it_behaves_like 'delete instrument'
  end
end
