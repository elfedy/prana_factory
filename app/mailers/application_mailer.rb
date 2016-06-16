class ApplicationMailer < ActionMailer::Base
  default from: "info@pranafactory.com"
  add_template_helper EmailHelper
  layout 'mailer'
end
