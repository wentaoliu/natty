require 'rails_helper'
include LoginMacros

describe TopicsController do

  let(:topic) { create(:topic) }
  let(:valid_attributes) { attributes_for(:topic) }
  let(:invalid_attributes) { attributes_for(:invalid_topic) }

  shared_examples 'read topic' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 topics' do
        topic_0 = create_list(:topic, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:topics).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:topic) { create(:topic) }

      before :each do
        get :show, id: topic
      end

      it "assigns the requested topic to @topic" do
        expect(assigns(:topic)).to eq topic
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create topic' do
    describe 'GET #new' do
      it "assigns a new topic to @topic" do
        get :new
        expect(assigns(:topic)).to be_a_new(Topic)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new topic in the database" do
          expect{
            post :create, topic: attributes_for(:topic)
          }.to change(Topic, :count).by(1)
        end

        it "redirects to topic#show" do
          post :create, topic: attributes_for(:topic)
          expect(response).to redirect_to topic_path(assigns[:topic])
        end
      end

      context "with invalid attributes" do
        it "does not save the new topic in the database" do
          expect{
            post :create,
              topic: attributes_for(:invalid_topic)
          }.not_to change(Topic, :count)
        end

        it "re-renders the :new template" do
          post :create,
            topic: attributes_for(:invalid_topic)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'delete topic' do

    describe 'DELETE #destroy' do
      before :each do
        @topic = create(:topic)
      end

      it "deletes the topic" do
        expect{
          delete :destroy, id: @topic
        }.to change(Topic,:count).by(-1)
      end

      it "redirects to topic#index" do
        delete :destroy, id: @topic
        expect(response).to redirect_to topics_url
      end
    end
  end

  describe "user with full permission to topic" do
    before :each do
      sign_in
    end

    it_behaves_like 'read topic'
    it_behaves_like 'create topic'
    it_behaves_like 'delete topic'
  end
end
