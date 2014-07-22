class Transaction
  include Mongoid::Document

  field :upper, type: BigDecimal
  field :middle, type: BigDecimal
  field :lower, type: BigDecimal
  field :average, type: BigDecimal
  field :averageChange, type: BigDecimal
  field :volume, type: BigDecimal
  field :volumeChange, type: BigDecimal
  field :date, type: Date

  belongs_to :product
  belongs_to :market
end
