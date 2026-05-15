class ApplicationController < ActionController::API
  include Pagy::Backend
  before_action :authorize_request
  def decoded_token
    auth_header = request.headers['Authorization']
    return nil unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @current_user ||= User.find_by(id: user_id)
    end
  end


  def authorize_request
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end
    def pagination_metadata(pagy)
    {
      current_page:   pagy.page,
      total_pages:    pagy.pages,
      total_count:    pagy.count,
      items_per_page: pagy.limit,   # Pagy v9: renamed from .items → .limit
      next_page:      pagy.next,
      prev_page:      pagy.prev
    }
  end
end
