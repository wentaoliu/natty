require 'rails_helper'
include LoginMacros

describe MeetingsController do

  let(:meeting) { create(:meeting) }
  let(:valid_attributes) { attributes_for(:meeting) }
  let(:invalid_attributes) { attributes_for(:invalid_meeting) }

  shared_examples 'read meeting' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 meetings' do
        meeting_0 = create_list(:meeting, 15)
        get :index
        expect(response).to be_success
        expect(assigns(:meetings).length).to eq 15
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:meeting) { create(:meeting) }

      before :each do
        get :show, id: meeting
      end

      it "assigns the requested meeting to @meeting" do
        expect(assigns(:meeting)).to eq meeting
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create meeting' do
    describe 'GET #new' do
      it "assigns a new meeting to @meeting" do
        get :new
        expect(assigns(:meeting)).to be_a_new(Meeting)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new meeting in the database" do
          expect{
            post :create, meeting: attributes_for(:meeting)
          }.to change(Meeting, :count).by(1)
        end

        it "redirects to meeting#show" do
          post :create, meeting: attributes_for(:meeting)
          expect(response).to redirect_to meeting_path(assigns[:meeting])
        end
      end

      context "with invalid attributes" do
        it "does not save the new meeting in the database" do
          expect{
            post :create,
              meeting: attributes_for(:invalid_meeting)
          }.not_to change(Meeting, :count)
        end

        it "re-renders the :new template" do
          post :create,
            meeting: attributes_for(:invalid_meeting)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit meeting' do

    describe 'GET #edit' do
      it "assigns the requested meeting to @meeting" do
        meeting = create(:meeting)
        get :edit, id: meeting
        expect(assigns(:meeting)).to eq meeting
      end

      it "renders the :edit template" do
        meeting = create(:meeting)
        get :edit, id: meeting
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @meeting = create(:meeting)
      end

      context "valid attributes" do
        it "locates the requested @meeting" do
          allow(meeting).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @meeting,
            meeting: attributes_for(:meeting)
          expect(assigns(:meeting)).to eq @meeting
        end

        it "changes the meeting's attributes" do
          patch :update, id: @meeting,
            meeting: attributes_for(:meeting,
              title: 'Hello world!'
            )
          @meeting.reload
          expect(@meeting.title).to eq 'Hello world!'
        end

        it "redirects to the updated meeting" do
          patch :update, id: @meeting, meeting: attributes_for(:meeting)
          expect(response).to redirect_to @meeting
        end
      end

      context "invalid attributes" do
        before :each do
          allow(meeting).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: meeting, meeting: invalid_attributes
        end

        it "locates the requested @meeting" do
          expect(assigns(:meeting)).to eq meeting
        end

        it "does not change the meeting's attributes" do
          expect(assigns(:meeting).reload.title).to eq meeting.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete meeting' do

    describe 'DELETE #destroy' do
      before :each do
        @meeting = create(:meeting)
      end

      it "deletes the meeting" do
        expect{
          delete :destroy, id: @meeting
        }.to change(Meeting,:count).by(-1)
      end

      it "redirects to meeting#index" do
        delete :destroy, id: @meeting
        expect(response).to redirect_to meetings_url
      end
    end
  end

  describe "user with full permission to meeting" do
    before :each do
      sign_in
    end

    it_behaves_like 'read meeting'
    it_behaves_like 'create meeting'
    it_behaves_like 'edit meeting'
    it_behaves_like 'delete meeting'
  end
end
