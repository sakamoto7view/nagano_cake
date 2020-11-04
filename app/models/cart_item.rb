class CartItem < ApplicationRecord
  belongs_to :customer
	belongs_to :item
	
  def price
    item.price * amount * 1.1
  end
	
end
