require 'rails_helper'
include LoginSupport

describe WikisController do

  let(:wiki) { create(:wiki) }
  let(:valid_attributes) { attributes_for(:wiki) }
  let(:invalid_attributes) { attributes_for(:invalid_wiki) }

  shared_examples 'read wiki' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 wikis' do
        wiki_0 = create_list(:wiki, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:wikis).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:wiki) { create(:wiki) }

      before :each do
        get :show, id: wiki
      end

      it "assigns the requested wiki to @wiki" do
        expect(assigns(:wiki)).to eq wiki
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create wiki' do
    describe 'GET #new' do
      it "assigns a new wiki to @wiki" do
        get :new
        expect(assigns(:wiki)).to be_a_new(Wiki)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new wiki in the database" do
          expect{
            post :create, wiki: attributes_for(:wiki)
          }.to change(Wiki, :count).by(1)
        end

        it "redirects to wiki#show" do
          post :create, wiki: attributes_for(:wiki)
          expect(response).to redirect_to wiki_path(assigns[:wiki])
        end
      end

      context "with invalid attributes" do
        it "does not save the new wiki in the database" do
          expect{
            post :create,
              wiki: attributes_for(:invalid_wiki)
          }.not_to change(Wiki, :count)
        end

        it "re-renders the :new template" do
          post :create,
            wiki: attributes_for(:invalid_wiki)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit wiki' do

    describe 'GET #edit' do
      it "assigns the requested wiki to @wiki" do
        wiki = create(:wiki)
        get :edit, id: wiki
        expect(assigns(:wiki)).to eq wiki
      end

      it "renders the :edit template" do
        wiki = create(:wiki)
        get :edit, id: wiki
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @wiki = create(:wiki)
      end

      context "valid attributes" do
        it "locates the requested @wiki" do
          allow(wiki).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @wiki,
            wiki: attributes_for(:wiki)
          expect(assigns(:wiki)).to eq @wiki
        end

        it "changes the wiki's attributes" do
          patch :update, id: @wiki,
            wiki: attributes_for(:wiki,
              title: 'Hello world!'
            )
          @wiki.reload
          expect(@wiki.title).to eq 'Hello world!'
        end

        it "redirects to the updated wiki" do
          patch :update, id: @wiki, wiki: attributes_for(:wiki)
          expect(response).to redirect_to @wiki
        end
      end

      context "invalid attributes" do
        before :each do
          allow(wiki).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: wiki, wiki: invalid_attributes
        end

        it "locates the requested @wiki" do
          expect(assigns(:wiki)).to eq wiki
        end

        it "does not change the wiki's attributes" do
          expect(assigns(:wiki).reload.title).to eq wiki.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete wiki' do

    describe 'DELETE #destroy' do
      before :each do
        @wiki = create(:wiki)
      end

      it "deletes the wiki" do
        expect{
          delete :destroy, id: @wiki
        }.to change(Wiki,:count).by(-1)
      end

      it "redirects to wiki#index" do
        delete :destroy, id: @wiki
        expect(response).to redirect_to wikis_url
      end
    end
  end

  describe "user with full permission to wiki" do
    before :each do
      sign_in
    end

    it_behaves_like 'read wiki'
    it_behaves_like 'create wiki'
    it_behaves_like 'edit wiki'
    it_behaves_like 'delete wiki'
  end
end
