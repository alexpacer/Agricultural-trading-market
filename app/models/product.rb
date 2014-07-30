class Product
  include Mongoid::Document

  field :name, type: String
  field :type, type: String
  field :process, type: String
  field :category, type: String

  has_many :transactions

  validates_presence_of :name, :type

  index({ name: 1, type: 1 }, { unique: true})



  def transactions_orderby_date(marketIds)

    cri = Transaction.where(:product_id => self.id )

    if(!marketIds.nil? && marketIds.count > 0)
      puts "aaa"
      cri = cri.where(:market_id.in => marketIds)
    end

    cri.sort(:date => 1)
  end

end
