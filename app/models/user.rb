class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_writer :access_token

  has_many :properties

  def refresh_access_token
    client = OAuth2::Client.new(ENV['GOOGLE_PUBLIC'], ENV['GOOGLE_PRIVATE'], site: 'https://accounts.google.com', authorize_url: '/o/oauth2/auth', token_url: '/o/oauth2/token')
    access_token = OAuth2::AccessToken.from_hash(client, refresh_token: self.refresh_token)
    @access_token = access_token.refresh!.token
  end

  def access_token
    @access_token || refresh_access_token
  end
end

