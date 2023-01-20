class User < ApplicationRecord
  validates :email, :first_name, :last_name, :address, presence: true, on: [:create]

  def save_with_email
    ApplicationRecord.transaction do
      save!
    end
    self
  rescue ActiveRecord::RecordInvalid
    false
  end
end
