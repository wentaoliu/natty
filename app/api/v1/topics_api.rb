module V1
  class TopicsAPI < Grape::API

    resource :topics do
      authorize_routes!

      before do
        token_authorize!
      end

      desc 'Get a list of topics'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Topic] do
        @topics = can?(:create, Topic) ? Topic : Topic.where(hidden: false)
        if params[:search].present?
          @topics = @topics.where(title: /.*#{params[:search]}.*/i)
        end
        @topics = @topics.order(updated_at: params[:order])
                         .page(params[:page])
                         .per(params[:per])
        present @topics
      end

      desc 'Create a new topic'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :category, type: String, desc: 'Category'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Topic] do
        @topic = Topic.new(title: params[:title], content: params[:content],
                           category: params[:category], hidden: params[:hidden])
        @topic.user = current_user
        if @topic.save
          present @topic
        else
          error!({ error: @topic.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get a topic'
        get '', authorize: [:read, Topic] do
          @topic = Topic.find(params[:id])
          @topic.inc(hits: 1)
          present @topic
        end

        desc 'delete a topic'
        delete '', authorize: [:manage, Topic] do
          @topic = Topic.find(params[:id])
          @topic.destroy
          { ok: 1 }
        end

        desc 'Get comments of a topic'
        get 'comments', authorize: [:read, Topic] do
          @topic = Topic.find(params[:id])
          @comments = @topic.comments

          present @comments
        end

        desc 'Create a comment'
        params do
          requires :content, type: String, desc: 'Content'
        end
        post 'comments', authorize: [:create, Comment] do
          @topic = Topic.find(params[:id])
          @comment = @topic.comments.new(content: params[:content])
          @comment.user = current_user
          if @comment.save
            present @comment
          else
            error!({ error: @comment.errors.full_messages }, 400)
          end
        end

      end

    end

  end
end
