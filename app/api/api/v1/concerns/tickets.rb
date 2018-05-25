# -*- coding: utf-8 -*-
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
         user = current_user
         activity = Activity.find_by(id: params.activitId)
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
      end
    end
  end
end
