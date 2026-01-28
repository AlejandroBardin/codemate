class ClientLogo < ApplicationRecord
  has_one_attached :logo_image

  validates :name, presence: true
  validates :logo_image, attached: true, content_type: %w[image/png image/jpeg image/webp image/svg+xml],
                         size: { less_than: 2.megabytes }

  scope :enabled, -> { where(enabled: true).order(:position) }
end
