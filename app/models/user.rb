class User < ApplicationRecord
  require 'csv'

  has_many :leads
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.import(file)
    CSV.foreach(file.path, header: true) do |row|
      User.create! row.to_hash
    end
  end
end
