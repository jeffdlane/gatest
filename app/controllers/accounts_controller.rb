class AccountsController < ApplicationController
  def index
    foo
    @account = Account.all
  end

  def create
    auth = env['omniauth.auth']
    credentials = auth['credentials']
    Account.create(access_token: credentials['token'], refresh_token: credentials['refresh_token'])
    redirect_to :accounts
  end

  def foo
    client = Google::APIClient.new
    client.authorization.access_token = Account.first.access_token
    service = client.discovered_api('analytics', 'v3')
    raise client.execute(
      api_method: service.management.accounts.list,
      parameters: {},
      headers: {'Content-Type' => 'application/json'}).inspect
  end
end
