require 'legato'
require 'oauth2'
require 'signet/oauth_2/client'

module LegatoGaUser
  SCOPE                 = 'https://www.googleapis.com/auth/analytics.readonly'.freeze
  TOKEN_CREDENTIAL_URI  = 'https://accounts.google.com/o/oauth2/token'.freeze
  AUDIENCE              = 'https://accounts.google.com/o/oauth2/token'.freeze
  AUTHORIZE_URL         = 'https://accounts.google.com/o/oauth2/auth'.freeze
  TOKEN_URL             = 'https://accounts.google.com/o/oauth2/token'.freeze

  private
  def create_ga_user(key_and_email_file='config/key_and_email.yml')
    signing_key = OpenSSL::PKey::RSA.new(private_key(key_and_email_file))
    auth_client = Signet::OAuth2::Client.new(
      token_credential_uri: TOKEN_CREDENTIAL_URI,
      audience: AUDIENCE,
      scope: SCOPE,
      issuer: client_email(key_and_email_file),
      signing_key: signing_key,
      sub: client_email(key_and_email_file),
    )
    access_token = auth_client.fetch_access_token!

    oauth_client = OAuth2::Client.new('', '', {
      authorize_url: AUTHORIZE_URL,
      token_url: TOKEN_URL,
    })

    token = OAuth2::AccessToken.new(
      oauth_client,
      access_token['access_token'],
      expires_in: access_token['expires_in'],
    )

    ga_user = Legato::User.new(token)
    ga_user.access_token.expired?

    ga_user
  end

  def private_key(key_and_email_file)
    YAML.load_file(key_and_email_file)['private_key']
  end

  def client_email(key_and_email_file)
    YAML.load_file(key_and_email_file)['client_email']
  end
end
