class UserMailer < ApplicationMailer
  default from: 'noreply@fable-insect-search.com'

  def confirm_new_email(user)
    @user = user
    mail(to: @user.email, subject: 'メールアドレス変更の確認')
  end

  def notify_old_email(old_email)
    mail(to: old_email, subject: 'メールアドレスが変更されました')
  end
end
