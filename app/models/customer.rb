class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy       
  
  enum is_deleted: {Available: true, Invalid: false} #https://qiita.com/tt_tsutsumi/items/588d0e65a289a15530d2
    #有効会員はtrue、退会済み会員はfalse

    def active_for_authentication?
        super && (self.is_deleted === "Available")
    end
  
end
