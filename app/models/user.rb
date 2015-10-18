class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save { self.email = email.downcase }
  
  has_many :products
  has_many :comments
  has_many :buyers, :class_name => 'Chat', :foreign_key => 'buyer_id'
  has_many :sellers, :class_name => 'Chat', :foreign_key => 'seller_id'
  has_many :messages

  def get_chats
    chats = []
      self.buyers.each do |chat|
        chats.push(chat)
      end
      self.sellers.each do |chat|
        chats.push(chat)
      end

    return (chats.sort_by {|obj| obj.messages.last.created_at}).reverse
  end

  def unread_messages
    if self.get_unread_messages.count != nil
      return self.get_unread_messages.count
    end
  end

  def get_unread_messages
    chats = []
      
      self.buyers.each do |chat|
        if chat.buyer_new == "1"
        chats.push(chat)
        end
      end

      self.sellers.each do |chat|
        if chat.seller_new == "1"
        chats.push(chat)
        end
      end
      return chats
  end

  def products_for_sale
      self.products.where(vendido: "No").count
  end

  def products_sold
    self.products.where(vendido: "Si").count
  end

end
