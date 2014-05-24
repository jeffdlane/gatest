class AccountsController < ApplicationController
  def current_account
    Account.first
  end

  def index
    @account = Account.all
  end

  def create
    auth = env['omniauth.auth']
    credentials = auth['credentials']
    Account.create(access_token: credentials['token'], refresh_token: credentials['refresh_token'])
    redirect_to :accounts
  end
end
