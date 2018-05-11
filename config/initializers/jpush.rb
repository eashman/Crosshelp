# frozen_string_literal: true
$jpush_client = JPush::Client.new(Settings.jpush.appkey, Settings.jpush.master_secret)
