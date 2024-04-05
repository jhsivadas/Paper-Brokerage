require 'httparty'
class AccountsController < ApplicationController
  def index
    matching_accounts = Account.all

    @list_of_accounts = matching_accounts.order({ :created_at => :desc })


    if current_user != nil

      accounts = Account.where({:user_id => current_user.id})
      @total = 0

      accounts.each do |account|
        @total = @total + account.cash + account.holdings
      end


      @api_key = 'co7n839r01qgik2hbd50co7n839r01qgik2hbd5g'
      

    

    # Calculate account holdings

    end
    




    render({ :template => "/accounts/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_accounts = Account.where({ :id => the_id })

    @the_account = matching_accounts.at(0)

    render({ :template => "accounts/show" })
  end

  def create
    the_account = Account.new
    the_account.holdings = params.fetch("query_holdings")
    the_account.cash = params.fetch("query_cash")
    the_account.user_id = params.fetch("query_user_id")

    if the_account.valid?
      the_account.save
      redirect_to("/accounts", { :notice => "Account created successfully." })
    else
      redirect_to("/accounts", { :alert => the_account.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_account = Account.where({ :id => the_id }).at(0)

    the_account.holdings = params.fetch("query_holdings")
    the_account.cash = params.fetch("query_cash")
    the_account.user_id = params.fetch("query_user_id")

    if the_account.valid?
      the_account.save
      redirect_to("/accounts/#{the_account.id}", { :notice => "Account updated successfully."} )
    else
      redirect_to("/accounts/#{the_account.id}", { :alert => the_account.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_account = Account.where({ :id => the_id }).at(0)

    the_account.destroy

    redirect_to("/accounts", { :notice => "Account deleted successfully."} )
  end
end
