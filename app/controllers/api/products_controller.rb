class Api::ProductsController < ApplicationController

  def index
    keyword = (params[:keyword].nil? || params[:keyword].empty?) ? ".*" : params[:keyword]
    products = Product.where(:name => /.*#{keyword}.*/i).sort(name: 1)
    render json: products
  end
  
  def show
    render json: Product.find_by(:id => params[:id])
  end

  def transactions
    product_id = params[:product_id]
    markets = params[:markets].nil? ? [] : params[:markets].split(",")

    marketIds = []
    markets.each do |code|
      marketIds.push Market.find_by(:code => code).id
    end

    transactions = Product.find_by(:id => product_id).transactions_orderby_date(marketIds)

    # 1185753600000, 20.62, 20.78, 19.94, 20.20, 277134788

    render json: {
      data: transactions.collect{|t| 
        [
          t.date.strftime('%Q').to_i,
          t.lower.to_f,
          t.upper.to_f,
          #t.middle.to_f, 
          #0
        ] 
      },
      volumes: transactions.collect{|t| 
        [
          t.date.strftime('%Q').to_i, 
          t.volume.to_i
        ]
      }
    }
  end

end
