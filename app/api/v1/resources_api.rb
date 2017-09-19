module V1
  class ResourcesAPI < Grape::API

    resource :resources do
      authorize_routes!

      before do
        doorkeeper_authorize!
      end

      desc 'Get a list of resources'
      params do
        optional :search, type: String
        optional :order, type: String, default: 'desc',
                         values: %w(desc asc)
        optional :page, type: Integer, default: 1
        optional :per, type: Integer, default: 10, values: 1..50
      end
      get '', authorize: [:read, Resource] do
        @resources = can?(:create, Resource) ? Resource : Resource.where(hidden: false)
        if params[:search].present?
          @resources = @resources.where(title: /.*#{params[:search]}.*/i)
        end
        @resources = @resources.order(updated_at: params[:order])
                             .page(params[:page])
                             .per(params[:per])
        present @resources
      end

      desc 'Create a new resource'
      params do
        requires :title, type: String, desc: 'Title'
        requires :parent, type: String, desc: 'Parent id'
        requires :ancestors, type: String, desc: 'ancestors ids'
        requires :is_folder, type: Boolean, desc: 'Is folder?'
        requires :hidden, type: Boolean, desc: 'Hidden?'
      end
      post '', authorize: [:create, Resource] do
        @resource = Resource.new(title: params[:title], parent: params[:parent],
                      ancestors: params[:ancestors], is_folder: params[:is_folder],
                      hidden: params[:hidden])
        @resource.user = current_user
        if @resource.save
          present @resource
        else
          error!({ error: @resource.errors.full_messages }, 400)
        end
      end

      namespace ':id' do

        desc 'Get a resource'
        get '', authorize: [:read, Resource] do
          @resource = Resource.find(params[:id])
          present @resource
        end

        desc 'Update a resource'
        params do
          requires :title, type: String, desc: 'Title'
          requires :parent, type: String, desc: 'Parent id'
          requires :ancestors, type: String, desc: 'ancestors ids'
          requires :is_folder, type: Boolean, desc: 'Is folder?'
          requires :hidden, type: Boolean, desc: 'Hidden?'
        end
        put '', authorize: [:update, Resource] do
          @resource = Resource.find(params[:id])
          if @resource.update(title: params[:title], parent: params[:parent],
                        ancestors: params[:ancestors], is_folder: params[:is_folder],
                        hidden: params[:hidden])
            present @resource
          else
            error!({ error: @resource.errors.full_messages }, 400)
          end
        end

        desc 'delete a resource'
        delete '', authorize: [:manage, Resource] do
          @resource = Resource.find(params[:id])
          @resource.destroy
          { ok: 1 }
        end

      end

    end

  end
end
