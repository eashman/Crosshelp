# frozen_string_literal: true
class JpushService
  def initialize(registration_id, extras, alert)
    @registration_id = registration_id
    @extras = extras
    @alert = alert
  end

  def invoke
    audience = JPush::Push::Audience.new.set_registration_id(@registration_id)

    notification = JPush::Push::Notification.new.
    set_alert(@alert).
    set_android(
      alert: @alert,
      title: @alert,
      builder_id: 2,
      extras: @extras
    ).set_ios(
      alert: @alert,
      sound: 'sound',
      badge: '+1',
      available: true,
      category: 'category',
      extras: @extras
    )

    push_payload = JPush::Push::PushPayload.new(
      platform: 'all',
      audience: audience,
      notification: notification
    ).set_message(
      @alert,
      title: @alert,
      content_type: nil,
      extras: @extras
    )

    push_payload.set_options(
      sendno: 1,
      apns_production: Settings.jpush.apns_production
    )

    push(push_payload)
  end

  private

  def push(push_payload)
    logger = Logger.new(Rails.root.join(Settings.logs.jpush))

    result = $jpush_client.pusher.push(push_payload)

    logger.info "jpush: #{result.inspect}"

    raise CommonError::CustomMessageError.new "极光发送有问题， 状态码： #{result.http_code}" if result.http_code != 200
  end
end
