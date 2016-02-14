require 'rails_helper'
include LoginSupport

describe CommentsController do

  let(:topic) { create(:topic) }
  let(:comment) { create(:comment, topic: topic) }
  let(:valid_attributes) { attributes_for(:comment) }
  let(:invalid_attributes) { attributes_for(:invalid_comment) }

  shared_examples 'create comment' do

    describe "POST #create" do
      context "with valid attributes" do
        it "redirects to topic#show" do
          post :create, comment: attributes_for(:comment), topic_id: topic
          expect(response).to redirect_to topic_path(topic)
        end
      end
    end
  end

  shared_examples 'delete comment' do

    describe 'DELETE #destroy' do

      it "redirects to @topic" do
        delete :destroy, id: comment, topic_id: topic
        expect(response).to redirect_to topic
      end
    end
  end

  describe "user with full permission to comment" do
    before :each do
      sign_in
    end

    it_behaves_like 'create comment'
    it_behaves_like 'delete comment'
  end
end
