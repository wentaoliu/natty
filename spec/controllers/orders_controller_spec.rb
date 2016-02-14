require 'rails_helper'
include LoginSupport

describe OrdersController do

  let(:order) { create(:order) }
  let(:valid_attributes) { attributes_for(:order) }
  let(:invalid_attributes) { attributes_for(:invalid_order) }

  shared_examples 'read order' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 orders' do
        order_0 = create_list(:order, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:orders).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:order) { create(:order) }

      before :each do
        get :show, id: order
      end

      it "assigns the requested order to @order" do
        expect(assigns(:order)).to eq order
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create order' do
    describe 'GET #new' do
      it "assigns a new order to @order" do
        get :new
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new order in the database" do
          expect{
            post :create, order: attributes_for(:order)
          }.to change(Order, :count).by(1)
        end

        it "redirects to order#show" do
          post :create, order: attributes_for(:order)
          expect(response).to redirect_to order_path(assigns[:order])
        end
      end

      context "with invalid attributes" do
        it "does not save the new order in the database" do
          expect{
            post :create,
              order: attributes_for(:invalid_order)
          }.not_to change(Order, :count)
        end

        it "re-renders the :new template" do
          post :create,
            order: attributes_for(:invalid_order)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit order' do

    describe 'GET #edit' do
      it "assigns the requested order to @order" do
        order = create(:order)
        get :edit, id: order
        expect(assigns(:order)).to eq order
      end

      it "renders the :edit template" do
        order = create(:order)
        get :edit, id: order
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @order = create(:order)
      end

      context "valid attributes" do
        it "locates the requested @order" do
          allow(order).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @order,
            order: attributes_for(:order)
          expect(assigns(:order)).to eq @order
        end

        it "changes the order's attributes" do
          patch :update, id: @order,
            order: attributes_for(:order,
              title: 'Hello world!'
            )
          @order.reload
          expect(@order.title).to eq 'Hello world!'
        end

        it "redirects to the updated order" do
          patch :update, id: @order, order: attributes_for(:order)
          expect(response).to redirect_to @order
        end
      end

      context "invalid attributes" do
        before :each do
          allow(order).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: order, order: invalid_attributes
        end

        it "locates the requested @order" do
          expect(assigns(:order)).to eq order
        end

        it "does not change the order's attributes" do
          expect(assigns(:order).reload.title).to eq order.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete order' do

    describe 'DELETE #destroy' do
      before :each do
        @order = create(:order)
      end

      it "deletes the order" do
        expect{
          delete :destroy, id: @order
        }.to change(Order,:count).by(-1)
      end

      it "redirects to order#index" do
        delete :destroy, id: @order
        expect(response).to redirect_to orders_url
      end
    end
  end

  describe "user with full permission to order" do
    before :each do
      sign_in
    end

    it_behaves_like 'read order'
    it_behaves_like 'create order'
    it_behaves_like 'edit order'
    it_behaves_like 'delete order'
  end
end
