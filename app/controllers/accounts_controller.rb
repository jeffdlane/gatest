class AccountsController < ApplicationController
  def index
    @account = Account.all
  end

  def new
    client = OAuth2::Client.new(ENV['GOOGLE_PUBLIC'], ENV['GOOGLE_PRIVATE'], site: 'https://accounts.google.com', authorize_url: '/o/oauth2/auth', token_url: '/o/oauth2/token')
    redirect_to client.auth_code.authorize_url(scope: 'https://www.googleapis.com/auth/userinfo.email', access_type: "offline", redirect_uri: callback_accounts_url, approval_prompt: 'force')
  end

  def create
    client = OAuth2::Client.new(ENV['GOOGLE_PUBLIC'], ENV['GOOGLE_PRIVATE'], site: 'https://accounts.google.com', authorize_url: '/o/oauth2/auth', token_url: '/o/oauth2/token')
    access_token = client.auth_code.get_token(params[:code], redirect_uri: callback_accounts_url) #, token_method: :post)
    Account.create(access_token: access_token.token, refresh_token: access_token.refresh_token)
    redirect_to :accounts
  end
end
