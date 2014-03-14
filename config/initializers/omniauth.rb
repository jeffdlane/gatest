Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_PUBLIC'], ENV['GOOGLE_PRIVATE'], prompt: 'consent', 
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/analytics'
end
