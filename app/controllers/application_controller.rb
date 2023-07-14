class ApplicationController < ActionController::Base
  before_action :require_login

  protected

    def authorized_domains
      @authorized_domains ||= ENV.fetch('AUTHORIZED_DOMAINS', '').split(',')
    end

    def require_login
      redirect_to login_path unless session[:user_email].present?
    end
end
