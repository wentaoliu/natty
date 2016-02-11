module V1
  class MeetingsAPI < Grape::API

    resource :meetings do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      desc 'Get a list of meetings'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Meeting] do
        @meetings = can?(:create, Meeting) ? Meeting : Meeting.where(hidden: false)
        if params[:search].present?
          @meetings = @meetings.where(title: /.*#{params[:search]}.*/i)
        end
        @meetings = @meetings.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @meetings
      end

      desc 'Create a new meeting'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :starts_at, type: DateTime, desc: 'Starts at'
        requires :ends_at, type: DateTime, desc: 'Ends at'
        requires :place, type: String, desc: 'Place'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Meeting] do
        @meeting = Meeting.new(title: params[:title], content: params[:content],
                           starts_at: params[:starts_at], ends_at: params[:ends_at],
                           place: params[:place], hidden: params[:hidden])
        @meeting.user = current_user
        if @meeting.save
          present @meeting
        else
          error!({ error: @meeting.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get a meeting'
        get '', authorize: [:read, Meeting] do
          @meeting = Meeting.find(params[:id])
          present @meeting
        end

        desc 'Update a meeting'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
          requires :starts_at, type: DateTime, desc: 'Starts at'
          requires :ends_at, type: DateTime, desc: 'Ends at'
          requires :place, type: String, desc: 'Place'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, News] do
          @meeting = Meeting.find(params[:id])
          if @meeting.update(title: params[:title], content: params[:content],
                             starts_at: params[:starts_at], ends_at: params[:ends_at],
                             place: params[:place], hidden: params[:hidden])
            present @meeting
          else
            error!({ error: @meeting.errors.full_messages }, 400)
          end
        end

        desc 'delete a meeting'
        delete '', authorize: [:manage, Meeting] do
          @meeting = Meeting.find(params[:id])
          @meeting.destroy
          { ok: 1 }
        end

      end

    end

  end
end
