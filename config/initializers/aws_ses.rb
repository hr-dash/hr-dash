if Rails.env.production?
  creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, credentials: creds, region: ENV['AWS_SES_REGION'])
end
