require 'rails_helper'
include LoginMacros

describe NewsController do

  let(:news) { create(:news) }
  let(:valid_attributes) { attributes_for(:news) }
  let(:invalid_attributes) { attributes_for(:invalid_news) }

  shared_examples 'read news' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 news' do
        news_0 = create_list(:news, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:news).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:news) { create(:news) }

      before :each do
        get :show, id: news
      end

      it "assigns the requested news to @news" do
        expect(assigns(:news)).to eq news
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create news' do
    describe 'GET #new' do
      it "assigns a new News to @news" do
        get :new
        expect(assigns(:news)).to be_a_new(News)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new news in the database" do
          expect{
            post :create, news: attributes_for(:news)
          }.to change(News, :count).by(1)
        end

        it "redirects to news#show" do
          post :create, news: attributes_for(:news)
          expect(response).to redirect_to news_path(assigns[:news])
        end
      end

      context "with invalid attributes" do
        it "does not save the new news in the database" do
          expect{
            post :create,
              news: attributes_for(:invalid_news)
          }.not_to change(News, :count)
        end

        it "re-renders the :new template" do
          post :create,
            news: attributes_for(:invalid_news)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit news' do

    describe 'GET #edit' do
      it "assigns the requested news to @news" do
        news = create(:news)
        get :edit, id: news
        expect(assigns(:news)).to eq news
      end

      it "renders the :edit template" do
        news = create(:news)
        get :edit, id: news
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @news = create(:news)
      end

      context "valid attributes" do
        it "locates the requested @news" do
          allow(news).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @news,
            news: attributes_for(:news)
          expect(assigns(:news)).to eq @news
        end

        it "changes the news's attributes" do
          patch :update, id: @news,
            news: attributes_for(:news,
              title: 'Hello world!'
            )
          @news.reload
          expect(@news.title).to eq 'Hello world!'
        end

        it "redirects to the updated news" do
          patch :update, id: @news, news: attributes_for(:news)
          expect(response).to redirect_to @news
        end
      end

      context "invalid attributes" do
        before :each do
          allow(news).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: news, news: invalid_attributes
        end

        it "locates the requested @news" do
          expect(assigns(:news)).to eq news
        end

        it "does not change the news's attributes" do
          expect(assigns(:news).reload.title).to eq news.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete news' do

    describe 'DELETE #destroy' do
      before :each do
        @news = create(:news)
      end

      it "deletes the news" do
        expect{
          delete :destroy, id: @news
        }.to change(News,:count).by(-1)
      end

      it "redirects to news#index" do
        delete :destroy, id: @news
        expect(response).to redirect_to news_url
      end
    end
  end

  describe "user with full permission to news" do
    before :each do
      sign_in
    end

    it_behaves_like 'read news'
    it_behaves_like 'create news'
    it_behaves_like 'edit news'
    it_behaves_like 'delete news'
  end
end
