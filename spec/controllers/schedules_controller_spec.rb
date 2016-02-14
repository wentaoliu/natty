require 'rails_helper'
include LoginSupport

describe SchedulesController do

  let(:schedule) { create(:schedule) }
  let(:valid_attributes) { attributes_for(:schedule) }
  let(:invalid_attributes) { attributes_for(:invalid_schedule) }

  shared_examples 'read schedule' do
    describe 'GET #index' do
      it 'populates an array of the latest 15 schedules' do
        schedule_0 = create_list(:schedule, 15)
        get :index
        expect(response).to be_success
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      let(:schedule) { create(:schedule) }

      before :each do
        get :show, id: schedule
      end

      it "assigns the requested schedule to @schedule" do
        expect(assigns(:schedule)).to eq schedule
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'create schedule' do
    describe 'GET #new' do
      it "assigns a new schedule to @schedule" do
        get :new
        expect(assigns(:schedule)).to be_a_new(Schedule)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new schedule in the database" do
          expect{
            post :create, schedule: attributes_for(:schedule)
          }.to change(Schedule, :count).by(1)
        end

        it "redirects to schedule#show" do
          post :create, schedule: attributes_for(:schedule)
          expect(response).to redirect_to schedule_path(assigns[:schedule])
        end
      end

      context "with invalid attributes" do
        it "does not save the new schedule in the database" do
          expect{
            post :create,
              schedule: attributes_for(:invalid_schedule)
          }.not_to change(Schedule, :count)
        end

        it "re-renders the :new template" do
          post :create,
            schedule: attributes_for(:invalid_schedule)
          expect(response).to render_template :new
        end
      end
    end
  end

  shared_examples 'edit schedule' do

    describe 'GET #edit' do
      it "assigns the requested schedule to @schedule" do
        schedule = create(:schedule)
        get :edit, id: schedule
        expect(assigns(:schedule)).to eq schedule
      end

      it "renders the :edit template" do
        schedule = create(:schedule)
        get :edit, id: schedule
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @schedule = create(:schedule)
      end

      context "valid attributes" do
        it "locates the requested @schedule" do
          allow(schedule).to \
            receive(:update).with(valid_attributes.stringify_keys) { true }
          patch :update, id: @schedule,
            schedule: attributes_for(:schedule)
          expect(assigns(:schedule)).to eq @schedule
        end

        it "changes the schedule's attributes" do
          patch :update, id: @schedule,
            schedule: attributes_for(:schedule,
              title: 'Hello world!'
            )
          @schedule.reload
          expect(@schedule.title).to eq 'Hello world!'
        end

        it "redirects to the updated schedule" do
          patch :update, id: @schedule, schedule: attributes_for(:schedule)
          expect(response).to redirect_to @schedule
        end
      end

      context "invalid attributes" do
        before :each do
          allow(schedule).to receive(:update).with(invalid_attributes.stringify_keys) { false }
          patch :update, id: schedule, schedule: invalid_attributes
        end

        it "locates the requested @schedule" do
          expect(assigns(:schedule)).to eq schedule
        end

        it "does not change the schedule's attributes" do
          expect(assigns(:schedule).reload.title).to eq schedule.title
        end

        it "re-renders the edit method" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  shared_examples 'delete schedule' do

    describe 'DELETE #destroy' do
      before :each do
        @schedule = create(:schedule)
      end

      it "deletes the schedule" do
        expect{
          delete :destroy, id: @schedule
        }.to change(Schedule,:count).by(-1)
      end

      it "redirects to schedule#index" do
        delete :destroy, id: @schedule
        expect(response).to redirect_to schedules_url
      end
    end
  end

  describe "user with full permission to schedule" do
    before :each do
      sign_in
    end

    it_behaves_like 'read schedule'
    it_behaves_like 'create schedule'
    it_behaves_like 'edit schedule'
    it_behaves_like 'delete schedule'
  end
end
