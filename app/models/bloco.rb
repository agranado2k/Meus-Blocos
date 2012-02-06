class Bloco < ActiveRecord::Base
  has_many :my_blocos
  has_many :users, :through => :my_blocos
end
