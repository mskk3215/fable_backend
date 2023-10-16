# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'noreply@fable-insect-search.com'

  def confirm_new_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('user_mailer.email_change_confirmation'))
  end

  def notify_old_email(old_email)
    mail(to: old_email, subject: I18n.t('user_mailer.email_change_notification'))
  end
end
