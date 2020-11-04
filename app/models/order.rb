class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
	has_many :items, through: :order_details
	accepts_nested_attributes_for :order_details
	belongs_to :customer

	#enaum_支払方法
	enum payment_method: {クレジットカード:1, 銀行振込:2}

	#注文ステータス
	enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}

	scope :created_today, -> { where(created_at: Time.zone.now.all_day) }


end
