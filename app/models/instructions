method in user model that makes API calls to retrieve accounts and build account models

result = client.execute()
accounts = result['data']['items']
account_numbers [{id: 123}, {id: 234}]
account_numbers.each do |n|
  Account.new(account_number: n)
end


def do_upload
    date = Time.now.strftime('%Y-%m-%d')
    media = Google::APIClient::UploadIO.new('public/data.csv', 'application/octet-stream')
    metadata = {
      'title'     => date,
      'mimeType'  => 'application/octet-stream',
      'resumable' => false
    }
    @client.execute(
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