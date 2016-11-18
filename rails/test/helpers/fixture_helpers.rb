module FixtureHelpers
  def default_password_digest
    Devise::Encryptor.digest(User, default_password)
  end

  def default_password
    'password'
  end
end