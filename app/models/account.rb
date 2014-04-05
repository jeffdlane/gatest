class Account < ActiveRecord::Base
  def client
    @client ||= refresh_client
  end

  def refresh_client
    client = Google::APIClient.new
    client.authorization.client_id = ENV['GOOGLE_PUBLIC']
    client.authorization.client_secret = ENV['GOOGLE_PRIVATE']
    client.authorization.refresh_token = self.refresh_token
    client.authorization.refresh!
    client
  end

  def analytics
    self.client.discovered_api('analytics', 'v3')
  end
end
