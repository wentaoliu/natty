require 'rails_helper'
include LoginMacros

describe MessagesController do

  let(:message) { create(:message) }
  let(:valid_attributes) { attributes_for(:message) }
  let(:invalid_attributes) { attributes_for(:invalid_message) }

  shared_examples 'create message' do

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new message in the database" do
          expect{
            post :create, message: attributes_for(:message)
          }.to change(Message, :count).by(1)
        end

        it "redirects to message#show" do
          post :create, message: attributes_for(:message)
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new message in the database" do
          expect{
            post :create,
              message: attributes_for(:invalid_message)
          }.not_to change(Message, :count)
        end

        it "redirect to root path" do
          post :create,
            message: attributes_for(:invalid_message)
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  shared_examples 'delete message' do

    describe 'DELETE #destroy' do
      before :each do
        @message = create(:message)
      end

      it "deletes the message" do
        expect{
          delete :destroy, id: @message
        }.to change(Message,:count).by(-1)
      end

      it "redirects to message#index" do
        delete :destroy, id: @message
        expect(response).to redirect_to messages_url
      end
    end
  end

  describe "user with full permission to message" do
    before :each do
      sign_in
    end

    it_behaves_like 'create message'
    it_behaves_like 'delete message'
  end
end
