# spec/support/login_macros.rb
module LoginMacros
  def login(user, password: "password123")
    post login_path, params: { email: user.email, password: password }
    follow_redirect! if response.redirect? # ログイン後の遷移も追いかける
  end
end
