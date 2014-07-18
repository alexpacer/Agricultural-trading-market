class Product
  include Mongoid::Document

  field :name, type: String
  field :type, type: String
  field :process, type: String

  has_many :transactions
end
