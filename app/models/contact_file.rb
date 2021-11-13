class ContactFile < ApplicationRecord
  has_one_attached :file

  enum status: {
    on_hold: "on hold",
    processing: "processing",
    failed: "failed",
    finished: "finished"
  }

  belongs_to :user
end
