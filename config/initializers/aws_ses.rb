if Rails.env.production?
  Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, { region: ENV['AWS_SES_REGION'] })
end
