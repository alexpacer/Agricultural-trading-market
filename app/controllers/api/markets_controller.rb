class Api::MarketsController < ApplicationController

  def index
    keyword = (params[:keyword].nil? || params[:keyword].empty?) ? ".*" : params[:keyword]
    markets = Market.where(:name => /.*#{keyword}.*/i).sort(name: 1)
    render json: markets
  end

end
