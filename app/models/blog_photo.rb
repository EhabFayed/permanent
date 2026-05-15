class BlogPhoto < ApplicationRecord
  belongs_to :blog
  has_one_attached :photo

  # validates :alt_ar, :alt_en, presence: true
    def cached_photo_url
    return nil unless photo.attached?

    Rails.cache.fetch("blog_photo_url_#{id}", expires_in: 12.hours) do
      Rails.application.routes.url_helpers.url_for(photo)
    end
  end

  private

  def clear_photo_cache
    Rails.cache.delete("blog_photo_url_#{id}")
  end
end
