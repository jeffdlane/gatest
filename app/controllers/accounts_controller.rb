class AccountsController < ApplicationController
  def current_account
    Account.first
  end

  def index
    do_list
    @account = Account.all
  end

  def create
    auth = env['omniauth.auth']
    credentials = auth['credentials']
    Account.create(refresh_token: credentials['refresh_token'])
    redirect_to :accounts
  end

  def index
    @accounts =  current_account.client.execute(
      api_method: current_account.analytics.management.accounts.list,
      parameters: {},
      headers: {'Content-Type' => 'application/json'})

    # raise current_account.client.execute(
      # api_method: current_account.analytics.management.accounts.list,
      # parameters: {},
      # headers: {'Content-Type' => 'application/json'}).inspect 

  end
     
  
end
