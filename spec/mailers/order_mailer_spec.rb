require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe 'order_confirmation' do
    let(:order) { create(:order) }
    let(:mail) { OrderMailer.order_confirmation(order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Potwierdzenie zamówienia')
      expect(mail.to).to eq(['test@wp.pl'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Dziękujemy za złożenie zamówienia.')
      expect(mail.body.encoded).to match('Oto lista produktów:')
    end
  end
end