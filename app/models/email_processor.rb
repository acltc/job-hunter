class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by_email(@email.from[:email])
    user.leads.create!(
      email: @email.to[0][:email],
      email_sent: true
    )
  end
end