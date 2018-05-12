module V1
  class InstrumentsAPI < Grape::API

    resource :instruments do
      authorize_routes!

      before do
        token_authorize!
      end

      desc 'Get a list of instruments'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Instrument] do
        @instruments = can?(:create, Instrument) ? Instrument : Instrument.where(hidden: false)
        if params[:search].present?
          @instruments = @instruments.where(title: /.*#{params[:search]}.*/i)
        end
        @instruments = @instruments.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @instruments
      end

      desc 'Create a new instrument'
      params do
        requires :title, type: String, desc: 'Title'
        requires :content, type: String, desc: 'Content'
        requires :maintainer, type: String, desc: 'Maintainer'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Instrument] do
        @instrument = Instrument.new(title: params[:title], content: params[:content],
                           maintainer: params[:maintainer], hidden: params[:hidden])
        @instrument.user = current_user
        if @instrument.save
          present @instrument
        else
          error!({ error: @instrument.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get an instrument'
        get '', authorize: [:read, Instrument] do
          @instrument = Instrument.find(params[:id])
          present @instrument
        end

        desc 'Update an instrument'
        params do
          requires :title, type: String, desc: 'Title'
          requires :content, type: String, desc: 'Content'
          requires :maintainer, type: String, desc: 'Maintainer'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, Instrument] do
          @instrument = Instrument.find(params[:id])
          if @instrument.update(title: params[:title], content: params[:content],
                             maintainer: params[:maintainer], hidden: params[:hidden])
            present @instrument
          else
            error!({ error: @instrument.errors.full_messages }, 400)
          end
        end

        desc 'delete an instrument'
        delete '', authorize: [:manage, Instrument] do
          @instrument = Instrument.find(params[:id])
          @instrument.destroy
          { ok: 1 }
        end

      end

    end

  end
end
