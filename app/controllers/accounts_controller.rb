class AccountsController < ApplicationController
  def index
    do_upload
    @account = Account.all
  end

  def create
    auth = env['omniauth.auth']
    credentials = auth['credentials']
    Account.create(access_token: credentials['token'], refresh_token: credentials['refresh_token'])
    redirect_to :accounts
  end

  def do_upload
    client = Google::APIClient.new
    client.authorization.access_token = Account.first.access_token
    analytics = client.discovered_api('analytics', 'v3')

    date = Time.now.strftime('%Y-%m-%d')
    media = Google::APIClient::UploadIO.new('public/data.csv', 'application/octet-stream')
    metadata = {
      'title'     => date,
      'mimeType'  => 'application/octet-stream',
      'resumable' => false
    }
    raise client.execute(
      api_method: analytics.management.daily_uploads.upload,
      parameters: { 'uploadType'          => 'multipart',
                    'appendNumber'        => 1,
                    'date'                => date,
                    'type'                => 'cost',
                    'accountId'           => '48677404',
                    'webPropertyId'       => 'UA-48677404-1',
                    'customDataSourceId'  => 'VgzS6Ob4RRWQIaxdHaVSug'
                  },
      media: media,
      body_object: metadata).inspect
  end
end
