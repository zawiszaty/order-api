class OrderConfirmationEmailJob < ApplicationJob
  queue_as :default

  def perform(order)
    OrderMailer.order_confirmation(order).deliver_now
  end
end
