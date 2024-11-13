# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    return @current_user if defined?(@current_user)

    # NOTE: Authentication would be required for real applications.
    user_email = request.headers["X-User-Email"]&.presence
    @current_user = user_email&.then { User.find_by(email: _1) }
  end
end
