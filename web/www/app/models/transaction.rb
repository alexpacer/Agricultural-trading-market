class Transaction
  include Mongoid::Document

  field :upper, type: BigDecimal
  field :middle, type: BigDecimal
  field :lower, type: BigDecimal
  field :average, type: BigDecimal
  field :averageChange, type: BigDecimal
  field :volumn, type: BigDecimal
  field :volumnChange, type: BigDecimal

  belongs_to :product
end
