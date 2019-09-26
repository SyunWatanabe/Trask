# frozen_string_literal: true

module LoginSupport
  def sign_in(user)
    visit root_path
    click_link 'Login'
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました！！'
  end
end
