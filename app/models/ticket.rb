# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id          :bigint(8)        not null, primary key
#  enter_id    :integer
#  order_id    :integer
#  activity_id :integer
#  state       :string           default("created")
#  code        :string
#  Qrcode      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ticket < ApplicationRecord
  belongs_to :enter
  belongs_to :order
  belongs_to :activity
  enumerize :state, in: [
    :created,    # 待参与
    :processing, # 参与
    :finish,     # 完成
    :cancel      # 已取消
  ], default: :created, predicates: { prefix: true }, scope: true

  before_create do
    generateCode
  end
  def generateCode
    number = [*(0..9)].sample(12).join
    loop do
      if $redisQr.sismember('code', number)
        number = [*(0..9)].sample(12).join
      else
        $redisQr.sadd('code', number)
       end
    end
    self.code = number
    self.Qrcode = generate_qr(number)
  end

  def generate_qr(code)
    file = '/tmp/qr_code.png'
    RQRCode::QRCode.new(code).as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 320,
      border_modules: 1,
      module_px_size: 6,
      file: file
    )
    object_key = SecureRandom.hex(16)
    name = "#{object_key}.png"
    result = Utils::Uploader.pubbucket.put_object(name, file: file)
    url = format('%s%s%s%s', 'https://', Settings.aliyun.pubhost, '/', name) if result
    url
  end
end
