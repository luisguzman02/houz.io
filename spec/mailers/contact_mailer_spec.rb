require "spec_helper"

describe ContactMailer do

  let(:contact) {contact = {user: 'amin', telephone: '6621838383', email: 'amin.ogarrio@gmail.com', message: 'lorem itsu'}}
  let(:mail) {mail = ContactMailer.contact_form(contact)}

  describe "test the contact mail" do
    it 'the subject should be correct' do
      expect(mail.subject).to eql("Contact form #{contact[:name]}")
    end

    it 'the email should send to me' do
      expect(mail.to).to eql(['info@houz.io'])
    end

    it 'the email should send from me' do
      expect(mail.from).to eql(['noreply@houz.io'])
    end
  end

  describe "test mail format" do
  	let(:body) {body = mail.body.encoded}
    it 'assign name' do
      expect(body).to match(contact[:user])
    end
    it 'assign telephone' do
      expect(body).to match(contact[:telephone])
    end
    it "assign email" do
    	expect(body).to match(contact[:email])
    end
    it "assign message" do
    	expect(body).to match(contact[:message])
    end
  end

end