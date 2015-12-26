module Api
  module V1
    class BucketlistsController < ApplicationController
      include UpdateHandler

      before_action :get_current_bucketlist, only: [:show, :update, :destroy]

      def index
        all_bucketlists = @current_user.bucketlists
        bucketlists = Api::Search.new(all_bucketlists, params).filter
        display_all Api::Pagination.new(bucketlists, params).start
      end

      def create
        bucketlist = Bucketlist.new(
          name: params[:name],
          user_id: @current_user.id
        )
        save bucketlist
      end

      def show
        render json: @bucketlist.to_json(include: :items)
      end

      def update
        return if params_arg_length_is_zero
        if @bucketlist.update bucketlist_params
          render json: { "message": "Bucketlist updated successfully" }
        else
          render json: { "message": @bucketlist.get_error },
                 status: 400
        end
      end

      def destroy
        @bucketlist.destroy
        render json: { "message": "Bucketlist deleted successfully" }
      end

      private

        def get_current_bucketlist
          @bucketlist = Bucketlist.find_by_id(params[:id])
          render json: { "message": "Invalid ID. Bucketlist not found." },
                 status: 404 if @bucketlist.nil?
        end

        def bucketlist_params
          params.permit(:name)
        end

        def display_all(bucketlists)
          if bucketlists.empty?
            render json: { "message": "Bucketlist empty" }, status: 204
          else
            render json: bucketlists.to_json(include: :items)
          end
        end

        def params_arg_length_is_zero
          if bucketlist_params.count == 0
            render json: {
              "message": "Name empty. Bucketlist could not updated."
            }, status: 400

            true
          end
        end
    end
  end
end
