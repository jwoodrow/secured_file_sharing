class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :ensure_domain, only: :create

  def new; end

  def create
    session[:user_email] = email
    redirect_to root_path
  end

  def destroy
    session.delete(:user_email)
    redirect_to login_path
  end

  protected

    def ensure_domain
      return if authorized_domains.none?
      return if email_domain.in?(authorized_domains)

      redirect_to login_path, alert: "You are not authorized to login with the #{email} account"
    end

    def email
      @email ||= request.env.fetch('omniauth.auth', {}).dig('info', 'email')
    end

    def email_domain
      @email_domain ||= email.split('@').last if email.present?
    end
end
