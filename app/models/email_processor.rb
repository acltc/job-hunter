class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    Lead.create!(email: @email.to )
  end
end