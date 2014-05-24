class Account < ActiveRecord::Base
  attr_writer :access_token

  def refresh_access_token
    client = OAuth2::Client.new(ENV['GOOGLE_PUBLIC'], ENV['GOOGLE_PRIVATE'], site: 'https://accounts.google.com', authorize_url: '/o/oauth2/auth', token_url: '/o/oauth2/token')
    access_token = OAuth2::AccessToken.from_hash(client, refresh_token: self.refresh_token)
    @access_token = access_token.refresh!.token
  end

  def access_token
    @access_token || refresh_access_token
  end

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
