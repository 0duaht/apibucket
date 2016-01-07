module Api
  module V1
    class BucketlistsController < ApplicationController
      include SaveHelper

      before_action :authenticate_token
      before_action :check_id_validity, :cancan_authorize,
                    only: [:show, :update, :destroy]

      def index
        all_bucketlists = current_user.bucketlists
        bucketlists = Api::Search.new(all_bucketlists, params).filter
        display_all Api::Pagination.new(bucketlists, params).start
      end

      def create
        bucketlist = Bucketlist.new(bucketlist_params)
        save bucketlist
      end

      def show
        render json: bucketlist
      end

      def update
        update_helper unless no_extra_params_passed
      end

      def destroy
        bucketlist.items.each(&:destroy)
        bucketlist.destroy
        render json: { "message": "Bucketlist deleted successfully" }
      end

      private

        def check_id_validity
          render json: { "message": "Invalid ID. Bucketlist not found." },
                 status: 404 if bucketlist.nil?
        end

        def bucketlist
          @bucketlist ||= Bucketlist.find_by_id(params[:id])
        end

        def bucketlist_params
          params.permit(:name).merge(user_id: current_user.id)
        end

        def display_all(bucketlists)
          if bucketlists.empty?
            head 204
          else
            render json: bucketlists, root: false
          end
        end

        def cancan_authorize
          authorize! params[:action], bucketlist
        end

        def update_helper
          if bucketlist.update bucketlist_params
            render json: { "message": "Bucketlist updated successfully" }
          else
            render json: { "message": bucketlist.get_error },
                   status: 400
          end
        end

        def no_extra_params_passed
          if bucketlist_params.count == 1
            render json: {
              "message": "Name empty. Bucketlist could not updated."
            }, status: 400

            true
          end
        end
    end
  end
end
