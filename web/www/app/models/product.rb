class Product
  include Mongoid::Document

  field :name, type: String
  field :type, type: String
  field :process, type: String
  field :category, type: String

  has_many :transactions

  validates_presence_of :name, :type

  index({ name: 1, type: 1 }, { unique: true})



  def transactions_orderby_date 
    Transaction.where(:product_id => self.id ).sort(:date => 1)
  end

end
