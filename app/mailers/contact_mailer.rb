class ContactMailer < ActionMailer::Base
  default from: 'noreply@houz.io'

  def contact_form(contact_info)
    @contact_info = contact_info
    mail(to: 'info@houz.io', subject: "Contact form #{@contact_info[:name]}")
  end
end