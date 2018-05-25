# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Orders
        extend ActiveSupport::Concern
        included do
          desc '用户订单 [GET /orders/list]'
          get '/orders/list' do
            user = current_user
            orders = user.orders
            wrap_meta(
              orders: Entities::OrderList.represent(orders).as_json
            )
          end
        end
      end
    end
  end
end
