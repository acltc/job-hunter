class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    # Lead.create!(email: @email.to)
    @user = User.find_by!(email: @email.from[:email])
    @user.leads.create!(email: @email.to)
  end
end