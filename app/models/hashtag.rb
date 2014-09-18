# == Schema Information
#
# Table name: hashtags
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  refreshed_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  slug            :string(255)
#  min_tag_id      :string(255)      default("0")
#  max_tag_id      :string(255)
#  is_active       :boolean          default(TRUE)
#  instagram_count :integer          default(0)
#
# Indexes
#
#  index_hashtags_on_slug  (slug) UNIQUE
#

class Hashtag < ActiveRecord::Base

  has_many :instagram_media_hashtags
  has_many :instagram_medias, through: :instagram_media_hashtags

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  # after_create :scrape_instagram

  def persist_refresh(options)
    update_attributes options.slice(:min_tag_id, :max_tag_id).compact.merge(refreshed_at: Time.now)
  end

  def scrape_instagram
    HashtagScraper.fetch_tag_sequence(name)
  end

end

