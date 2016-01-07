module Api
  module V1
    class ItemsController < ApplicationController
      include SaveHelper

      before_action :authenticate_token
      before_action :check_id_validity, :cancan_authorize,
                    except: [:create]

      def create
        item = Item.new(item_params)
        save item
      end

      def update
        update_helper unless no_extra_params_passed
      end

      def destroy
        item.destroy
        render json: { "message": "Item deleted successfully" }
      end

      private

        def item_params
          params.permit(:name, :done).merge(
            bucketlist_id: params[:bucketlist_id]
          )
        end

        def item
          @item ||= Item.find_by_id(params[:id])
        end

        def check_id_validity
          render json: { "message": "Invalid ID. Item not found." },
                 status: 404 if item.nil?
        end

        def cancan_authorize
          authorize! params[:action], item
        end

        def update_helper
          if item.update item_params
            render json: { "message": "Item updated successfully" }
          else
            render json: { "message": item.get_error }, status: 400
          end
        end

        def no_extra_params_passed
          if item_params.count == 1
            render json: {
              "message": "Parameters empty. Item could not updated."
            }, status: 400

            true
          end
        end
    end
  end
end
