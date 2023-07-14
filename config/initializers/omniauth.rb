Rails.application.reload_routes!
Rails.application.config.middleware.use OmniAuth::Builder do
  # Application providers (user.identities)
  provider(
    :google_oauth2, # rubocop:disable Naming/VariableNumber
    ENV.fetch('GOOGLE_CLIENT_ID', nil),
    ENV.fetch('GOOGLE_CLIENT_SECRET', nil),
    prompt:       'select_account',
    scope:        'email',
    redirect_uri: Rails.application.routes.url_helpers.google_auth_url(
      host: ENV.fetch('CANONICAL_DOMAIN_NAME', 'http://localhost:3200')
    )
  )
end

OmniAuth.config.allowed_request_methods = %i[get]
