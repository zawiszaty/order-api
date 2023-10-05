require 'rails_helper'

RSpec.describe OrderConfirmationEmailJob, type: :job do
  describe '#perform' do
    it 'sends an email' do
      order = create(:order)

      expect { OrderConfirmationEmailJob.perform_now(order) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
