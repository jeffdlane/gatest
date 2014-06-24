class UploadController < ApplicationController
  def new
  end

  def create
    @source = Source.find(params[:source_id])
    @property = Property.find(params[:property_id])
    client = Google::APIClient.new
    client.authorization.access_token = Account.last.access_token
    analytics = client.discovered_api('analytics', 'v3')

    # file = StringIO.new(GoogleAnalytics::CSVConverter.new(params[:csv],@source.ga_source, @source.ga_medium).to_s)
    file = params[:csv]
    date = params[:date]
    accountId = @property.ga_property_id[/\d+/]
    webPropertyId = @property.ga_property_id
    customDataSourceId = @property.custom_data_id
    media = Google::APIClient::UploadIO.new(file, 'application/octet-stream')
    metadata = {
      'title'     => date,
      'mimeType'  => 'application/octet-stream',
      'resumable' => false
    }
   # raise accountId.class.inspect
    raise client.execute(
      api_method: analytics.management.daily_uploads.upload,
      parameters: { 'uploadType'          => 'multipart',
                    'appendNumber'        => 1,
                    'date'                => date,
                    'type'                => 'cost',
                    'accountId'           => accountId,
                    'webPropertyId'       => webPropertyId,
                    'customDataSourceId'  => customDataSourceId
                  },
      media: media,
      body_object: metadata).inspect
  end
  
end
