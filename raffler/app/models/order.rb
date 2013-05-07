class Order < ActiveRecord::Base
  has_many :items
  attr_accessible :patron, :total
end