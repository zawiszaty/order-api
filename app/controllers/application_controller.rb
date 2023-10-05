class ApplicationController < ActionController::API
  protected

  def error
    ErrorSerializer.new(@product).serializable_hash
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: 'Unauthorized'}, status: :unauthorized
    end
  end
end
