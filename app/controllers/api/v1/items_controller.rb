module Api
  module V1
    class ItemsController < ApplicationController
      include UpdateHandler

      before_action :get_current_item, except: [:create]

      def create
        item = Item.new(
          name: params[:name],
          bucketlist_id: params[:bucketlist_id]
        )
        save item
      end

      def update
        authorize_action :update
        return if params_arg_length_is_zero
        update_helper
      end

      def destroy
        authorize_action :destroy
        @item.destroy
        render json: { "message": "Item deleted successfully" }
      end

      private

        def item_params
          params.permit(:name, :done)
        end

        def authorize_action(action)
          authorize! action, @item
        end

        def get_current_item
          @item = Item.find_by_id(params[:id])
          render json: { "message": "Invalid ID. Item not found." },
                 status: 404 if @item.nil?
        end

        def update_helper
          if @item.update item_params
            render json: { "message": "Item updated successfully" }
          else
            render json: { "message": @item.get_error }, status: 400
          end
        end

        def params_arg_length_is_zero
          if item_params.count == 0
            render json: {
              "message": "Parameters empty. Item could not updated."
            }, status: 400

            true
          end
        end
    end
  end
end
