Warden::Manager.after_authentication do |user, auth, opts|
    UserMailer.welcome_email(user).deliver_later
end
