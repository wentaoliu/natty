require 'rails_helper'
include LoginMacros

describe ResourcesController do

  let(:resource) { create(:resource) }
  let(:valid_attributes) { attributes_for(:resource) }
  let(:invalid_attributes) { attributes_for(:invalid_resource) }

  shared_examples 'read resource' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 resources' do
        resource_0 = create_list(:resource, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:resources).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "user with full permission to resource" do
    before :each do
      sign_in
    end

    it_behaves_like 'read resource'
  end
end
