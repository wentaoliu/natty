require 'rails_helper'
include LoginSupport

describe InventoriesController do

  let(:inventory) { create(:inventory) }
  let(:valid_attributes) { attributes_for(:inventory) }
  let(:invalid_attributes) { attributes_for(:invalid_inventory) }

  shared_examples 'read inventory' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 inventories' do
        inventory_0 = create_list(:inventory, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:inventories).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:inventory) { create(:inventory) }

      before :each do
        get :show, id: inventory
      end

      it "assigns the requested inventory to @inventory" do
        expect(assigns(:inventory)).to eq inventory
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create inventory' do
    describe 'GET #new' do
      it "assigns a new inventory to @inventory" do
        get :new
        expect(assigns(:inventory)).to be_a_new(Inventory)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new inventory in the database" do
          expect{
            post :create, inventory: attributes_for(:inventory)
          }.to change(Inventory, :count).by(1)
        end

        it "redirects to inventory#show" do
          post :create, inventory: attributes_for(:inventory)
          expect(response).to redirect_to inventory_path(assigns[:inventory])
        end
      end

      context "with invalid attributes" do
        it "does not save the new inventory in the database" do
          expect{
            post :create,
              inventory: attributes_for(:invalid_inventory)
          }.not_to change(Inventory, :count)
        end

        it "re-renders the :new template" do
          post :create,
            inventory: attributes_for(:invalid_inventory)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit inventory' do

    describe 'GET #edit' do
      it "assigns the requested inventory to @inventory" do
        inventory = create(:inventory)
        get :edit, id: inventory
        expect(assigns(:inventory)).to eq inventory
      end

      it "renders the :edit template" do
        inventory = create(:inventory)
        get :edit, id: inventory
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @inventory = create(:inventory)
      end

      context "valid attributes" do
        it "locates the requested @inventory" do
          allow(inventory).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @inventory,
            inventory: attributes_for(:inventory)
          expect(assigns(:inventory)).to eq @inventory
        end

        it "changes the inventory's attributes" do
          patch :update, id: @inventory,
            inventory: attributes_for(:inventory,
              item_name: 'Hello world!'
            )
          @inventory.reload
          expect(@inventory.item_name).to eq 'Hello world!'
        end

        it "redirects to the updated inventory" do
          patch :update, id: @inventory, inventory: attributes_for(:inventory)
          expect(response).to redirect_to @inventory
        end
      end

      context "invalid attributes" do
        before :each do
          allow(inventory).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: inventory, inventory: invalid_attributes
        end

        it "locates the requested @inventory" do
          expect(assigns(:inventory)).to eq inventory
        end

        it "does not change the inventory's attributes" do
          expect(assigns(:inventory).reload.item_name).to eq inventory.item_name
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete inventory' do

    describe 'DELETE #destroy' do
      before :each do
        @inventory = create(:inventory)
      end

      it "deletes the inventory" do
        expect{
          delete :destroy, id: @inventory
        }.to change(Inventory,:count).by(-1)
      end

      it "redirects to inventory#index" do
        delete :destroy, id: @inventory
        expect(response).to redirect_to inventories_url
      end
    end
  end

  describe "user with full permission to inventory" do
    before :each do
      sign_in
    end

    it_behaves_like 'read inventory'
    it_behaves_like 'create inventory'
    it_behaves_like 'edit inventory'
    it_behaves_like 'delete inventory'
  end
end
