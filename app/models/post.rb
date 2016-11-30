class Post < ApplicationRecord
  validates :caption, presence: true, length: {minimum: 3 }
  validates :image, presence: true
  validates :user_id, presence: true

  scope :sorted, -> {order("created_at DESC")}
  
  has_attached_file :image, styles: { medium: "640x" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, :less_than => 2.megabytes

  belongs_to :user
  has_many :comments, dependent: :destroy

end
