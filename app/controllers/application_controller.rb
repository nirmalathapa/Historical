class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  def set_layout
    if devise_controller?
      'simple'
    else
      'application'
    end
  end
end
