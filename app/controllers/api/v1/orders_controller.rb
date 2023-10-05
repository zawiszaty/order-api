# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authorize_request
      def create
        order = Order.new
        order_params[:order_products_attributes].each do |order_product_params|
          order.order_product.build(order_product_params)
        end
        order.save!
        OrderConfirmationEmailJob.perform_later(order)


        render json: order, status: :created
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def show
        @order = Order.find(params[:id])
        options = { include: [:order_products] }
        render json: OrderSerializer.new(@order, options).serializable_hash.to_json
      end

      private

      def order_params
        params.require(:order).permit(order_products_attributes: [:product_id, :amount])
      end
    end
  end
end