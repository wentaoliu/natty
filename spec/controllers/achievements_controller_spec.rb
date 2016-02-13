require 'rails_helper'
include LoginMacros

describe AchievementsController do

  let(:achievement) { create(:achievement) }
  let(:valid_attributes) { attributes_for(:achievement) }
  let(:invalid_attributes) { attributes_for(:invalid_achievement) }

  shared_examples 'read achievement' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 achievements' do
        achievement_0 = create_list(:achievement, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:achievements).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:achievement) { create(:achievement) }

      before :each do
        get :show, id: achievement
      end

      it "assigns the requested achievement to @achievement" do
        expect(assigns(:achievement)).to eq achievement
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create achievement' do
    describe 'GET #new' do
      it "assigns a new achievement to @achievement" do
        get :new
        expect(assigns(:achievement)).to be_a_new(Achievement)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new achievement in the database" do
          expect{
            post :create, achievement: attributes_for(:achievement)
          }.to change(Achievement, :count).by(1)
        end

        it "redirects to achievement#show" do
          post :create, achievement: attributes_for(:achievement)
          expect(response).to redirect_to achievement_path(assigns[:achievement])
        end
      end

      context "with invalid attributes" do
        it "does not save the new achievement in the database" do
          expect{
            post :create,
              achievement: attributes_for(:invalid_achievement)
          }.not_to change(Achievement, :count)
        end

        it "re-renders the :new template" do
          post :create,
            achievement: attributes_for(:invalid_achievement)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit achievement' do

    describe 'GET #edit' do
      it "assigns the requested achievement to @achievement" do
        achievement = create(:achievement)
        get :edit, id: achievement
        expect(assigns(:achievement)).to eq achievement
      end

      it "renders the :edit template" do
        achievement = create(:achievement)
        get :edit, id: achievement
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @achievement = create(:achievement)
      end

      context "valid attributes" do
        it "locates the requested @achievement" do
          allow(achievement).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @achievement,
            achievement: attributes_for(:achievement)
          expect(assigns(:achievement)).to eq @achievement
        end

        it "changes the achievement's attributes" do
          patch :update, id: @achievement,
            achievement: attributes_for(:achievement,
              title: 'Hello world!'
            )
          @achievement.reload
          expect(@achievement.title).to eq 'Hello world!'
        end

        it "redirects to the updated achievement" do
          patch :update, id: @achievement, achievement: attributes_for(:achievement)
          expect(response).to redirect_to @achievement
        end
      end

      context "invalid attributes" do
        before :each do
          allow(achievement).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: achievement, achievement: invalid_attributes
        end

        it "locates the requested @achievement" do
          expect(assigns(:achievement)).to eq achievement
        end

        it "does not change the achievement's attributes" do
          expect(assigns(:achievement).reload.title).to eq achievement.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete achievement' do

    describe 'DELETE #destroy' do
      before :each do
        @achievement = create(:achievement)
      end

      it "deletes the achievement" do
        expect{
          delete :destroy, id: @achievement
        }.to change(Achievement,:count).by(-1)
      end

      it "redirects to achievement#index" do
        delete :destroy, id: @achievement
        expect(response).to redirect_to achievements_url
      end
    end
  end

  describe "user with full permission to achievement" do
    before :each do
      sign_in
    end

    it_behaves_like 'read achievement'
    it_behaves_like 'create achievement'
    it_behaves_like 'edit achievement'
    it_behaves_like 'delete achievement'
  end
end
