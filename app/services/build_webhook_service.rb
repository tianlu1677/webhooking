class BuildWebhookService
  attr_accessor :user, :cookies
  def initialize(user = nil, cookies)
    @user = user
    @cookies = cookies
  end

  def find_or_create!
    # byebug
    puts "cookie_token #{cookie_token}"
    if cookie_token.blank?
      cookies.encrypted['webhook_token'] = SecureRandom.hex
    end

    webhook = Webhook.find_or_create_by(user_id: @user&.id, webhook_token: cookie_token)
    webhook
  end

  def cookie_token
    cookies.encrypted['webhook_token']
  end

  def cookie_token=(value)
    # byebug
    cookies.encrypted['webhook_token'] = value
  end
end