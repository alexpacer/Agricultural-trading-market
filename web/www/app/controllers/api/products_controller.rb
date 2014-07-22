class Api::ProductsController < ApplicationController

  def index
    keyword = (params[:keyword].nil? || params[:keyword].empty?) ? ".*" : params[:keyword]
    products = Product.where(:name => /.*#{keyword}.*/i)
    render json: products
  end
  
end
