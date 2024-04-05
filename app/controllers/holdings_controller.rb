class HoldingsController < ApplicationController
  def index
    matching_holdings = Holding.all

    @list_of_holdings = matching_holdings.order({ :created_at => :desc })

    render({ :template => "holdings/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_holdings = Holding.where({ :id => the_id })

    @the_holding = matching_holdings.at(0)

    render({ :template => "holdings/show" })
  end

  def create
    the_holding = Holding.new
    the_holding.ticker = params.fetch("query_ticker")
    the_holding.shares = params.fetch("query_shares")
    the_holding.account_id = params.fetch("query_account_id")

    if the_holding.valid?
      the_holding.save
      redirect_to("/holdings", { :notice => "Holding created successfully." })
    else
      redirect_to("/holdings", { :alert => the_holding.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_holding = Holding.where({ :id => the_id }).at(0)

    the_holding.ticker = params.fetch("query_ticker")
    the_holding.shares = params.fetch("query_shares")
    the_holding.account_id = params.fetch("query_account_id")

    if the_holding.valid?
      the_holding.save
      redirect_to("/holdings/#{the_holding.id}", { :notice => "Holding updated successfully."} )
    else
      redirect_to("/holdings/#{the_holding.id}", { :alert => the_holding.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_holding = Holding.where({ :id => the_id }).at(0)

    the_holding.destroy

    redirect_to("/holdings", { :notice => "Holding deleted successfully."} )
  end
end
