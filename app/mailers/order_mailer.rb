class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(to: 'test@wp.pl', subject: 'Potwierdzenie zamówienia')
  end
end
