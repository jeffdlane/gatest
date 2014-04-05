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

  def do_list
    raise current_account.client.execute(
      api_method: current_account.analytics.management.accounts.list,
      parameters: {},
      headers: {'Content-Type' => 'application/json'}).inspect 
  end
     
  def do_upload
    date = Time.now.strftime('%Y-%m-%d')
    media = Google::APIClient::UploadIO.new('public/data.csv', 'application/octet-stream')
    metadata = {
      'title'     => date,
      'mimeType'  => 'application/octet-stream',
      'resumable' => false
    }
    raise @client.execute(
      api_method: @analytics.management.daily_uploads.upload,
      parameters: { 'uploadType'          => 'multipart',
                    'appendNumber'        => 1,
                    'date'                => date,
                    'type'                => 'cost',
                    'accountId'           => '44706033',
                    'webPropertyId'       => 'UA-44706033-1',
                    'customDataSourceId'  => '7LwIbTS7R8m7kc_EFXjJzQ'
                  },
      media: media,
      body_object: metadata).inspect
  end
end
