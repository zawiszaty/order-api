# frozen_string_literal: true

class ErrorSerializer
  include JSONAPI::Serializer

  def initialize(record)
    @record = record
  end

  def serializable_hash
    {
      errors: record.errors.details.map do |field, error_details|
        {
          status: '422',
          title: 'Unprocessable Entity',
          detail: "#{field.to_s.humanize} #{error_message(error_details)}"
        }
      end
    }
  end

  private

  attr_reader :record

  def error_message(error_details)
    error_details.map { |error| error[:error] }.join(', ')
  end
end