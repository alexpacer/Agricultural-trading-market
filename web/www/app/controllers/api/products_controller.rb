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
    transactions = Product.find_by(:id => product_id).transactions

    render json: transactions.collect{|t| 
      [t.date.strftime('%Q').to_i, t.average.to_f, t.upper.to_f, t.middle.to_f, t.lower.to_f ] }
  end

end
