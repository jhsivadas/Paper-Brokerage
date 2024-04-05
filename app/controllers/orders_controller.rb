require 'httparty'
class OrdersController < ApplicationController
  def index
    matching_orders = Order.all

    @list_of_orders = matching_orders.order({ :created_at => :desc })

    @api_key = 'co7n839r01qgik2hbd50co7n839r01qgik2hbd5g'

    render({ :template => "orders/index", :layout => false})
  end

  def show
    the_id = params.fetch("path_id")

    matching_orders = Order.where({ :id => the_id })

    @the_order = matching_orders.at(0)

    render({ :template => "orders/show" })
  end

  def create
    @api_key = 'co7n839r01qgik2hbd50co7n839r01qgik2hbd5g'
    
    url = "https://finnhub.io/api/v1/quote?symbol=#{params[:query_ticker]}&token=#{@api_key}"
    response = HTTParty.get(url)
    quote = response.parsed_response


    
    the_order = Order.new
    the_order.ticker = params.fetch("query_ticker").upcase
    the_order.shares = params.fetch("query_shares")
    the_order.type = params[:query_type]
    the_order.user_id = params.fetch("query_user_id")
    the_order.account_id = params.fetch("query_account_id")

    if the_order.type.to_s == "Buy" 
      the_holding = Holding.new
      the_holding.purchase_price = quote.fetch("c") #tbu
      the_holding.shares = params[:query_shares]
      the_holding.ticker = params[:query_ticker].upcase
      the_holding.account_id = params[:query_account_id]
      the_holding.save

      account = Account.where(:id => params[:query_account_id]).at(0)
      account.cash = account.cash - the_holding.purchase_price * the_holding.shares
      account.holdings = account.holdings + the_holding.purchase_price * the_holding.shares
      account.save
    else
      sale = params[:query_shares].to_i
      holdings = Holding.where({:account_id=> params[:query_account_id], :ticker=> params[:query_ticker].upcase}).all
      account = Account.where({:id => params[:query_account_id]}).at(0)
      holdings.each do |holding|
        if holding.shares > sale
          holding.shares = holding.shares - sale
          account.holdings = account.holdings - sale * quote.fetch("c") #TBU
          account.cash = account.cash + sale * quote.fetch("c")
          holding.save
          account.save
          break
        elsif holding.shares == sale 
          # holding.destroy
          account.holdings = account.holdings - sale * quote.fetch("c")
          account.cash = account.cash + sale * quote.fetch("c")
          holding.shares = 0
          # sale = sale - holding.shares
          account.save
          
          holding.destroy
          holding.save
          break

        else
          account.holdings = account.holdings - holding.shares * quote.fetch("c") #TBU
          account.cash = account.cash + holding.shares * quote.fetch("c")
          account.save
          sale = sale - holding.shares
          holding.shares = 0
          holding.destroy

          holding.save
          
          # holding.save
        end

      end

    end

    if the_order.valid?
      the_order.save
      redirect_to("/accounts", { :notice => "Order created successfully." })
    else
      redirect_to("/accounts", { :alert => the_order.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_order = Order.where({ :id => the_id }).at(0)

    the_order.ticker = params.fetch("query_ticker")
    the_order.shares = params.fetch("query_shares")
    the_order.type = params.fetch("query_type")
    the_order.user_id = params.fetch("query_user_id")
    the_order.account_id = params.fetch("query_account_id")

    if the_order.valid?
      the_order.save
      redirect_to("/orders/#{the_order.id}", { :notice => "Order updated successfully."} )
    else
      redirect_to("/orders/#{the_order.id}", { :alert => the_order.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_order = Order.where({ :id => the_id }).at(0)

    the_order.destroy

    redirect_to("/orders", { :notice => "Order deleted successfully."} )
  end

  def route
    render({:template => "orders/getstock", :layout => false})

  end

  def find_order
    the_id = params[:path_id]
    stock = params[:query_holdings]
    type = params[:query_type]
    redirect_to("/orders/" + the_id + "/" + stock.to_s + "/" + type)

  end
end
