Rails.application.config.middleware.use OmniAuth::Builder do
  provider :flickr, '1a6a908e1a7fb467a461956216f24243', 'ab9257802ff21d26'
end