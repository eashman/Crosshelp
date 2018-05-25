# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Tickets
        extend ActiveSupport::Concern
        included do
          desc '查看电子票 [GET /tickets/show]'
          params do
            requires :activityId, type: String, desc: '活动ID'
          end
          get '/tickets/show' do
            user = current_user
            activity = Activity.find_by(id: params.activityId)
            ticket = Ticket.find_by(
              user_id: user.id,
              activity_id: params.activityId
            )
            wrap_meta(
              ticket: Entities::TicketList.represent(ticket).as_json,
              price: ticket.order.sum,
              activity: activity
            )
          end

          desc '验证电子票 [GET /tickets/checking]'
          params do
            requires :activityId, type: String, desc: '活动ID'
            requires :ticketCode, type: String, desc: '电子票编码'
          end
          get '/tickets/checking' do
            ticket = Ticket.where(
              code: params.ticketCode,
              activity_id: params.activityId
            ).first
            if ticket
              ticket.update!(state: 'processing')
              return wrap_meta(passed: true)
            else
              return wrap_meta(passed: false)
            end
          end

          desc '退票 [POST /tickets/return]'
          params do
            requires :ticketId, type: String, desc: '电子票ID'
            requires :remark, type: String, desc: '退票理由'
          end
          post '/tickets/return' do
            user = current_user
            ticket = Ticket.find_by(id: params.ticketId, user_id: user.id)
            activity = Activity.find_by(id: ticket.activity_id)
            if activity.deadline.to_i < today.to_i
              ticket.update!(state: 'cancel', remark: params.remark)
              return wrap_meta(msg: '退票成功等待退钱')
            else
              return wrap_meta(msg: '已经超过活动截止时间拒绝退票!')
            end
          end
        end
      end
    end
  end
end
