# == Schema Information
#
# Table name: instagram_media
#
#  id                :integer          not null, primary key
#  users_in_photo    :text
#  filter            :string(255)
#  tags              :text
#  comments          :text
#  caption           :text
#  likes             :text
#  created_time      :datetime
#  images            :text
#  instagram_id      :string(255)
#  location          :string(255)
#  videos            :text
#  created_at        :datetime
#  updated_at        :datetime
#  instagram_user_id :string(255)
#  media_type        :string(255)
#  is_displayable    :boolean          default(FALSE)
#

class InstagramMedia < ActiveRecord::Base

  # LIKES_MULTIPLIER = 3
  # COMMENTS_MULTIPLIER = 2
  # USERS_IN_PHOTO_MULTIPLIER = 1

  delegate :full_name, to: :instagram_user, prefix: true

  belongs_to :instagram_user
  has_many :instagram_media_hashtags
  has_many :hashtags, through: :instagram_media_hashtags

  validates :instagram_id, uniqueness: true

  serialize :tags,           Array
  serialize :likes,          Array
  serialize :images,         Hash
  serialize :videos,         Hash
  serialize :caption,        Hash
  serialize :location,       Hash
  serialize :comments,       Array
  serialize :users_in_photo, Array

  scope :randomized,  -> { order('RAND()') }
  scope :displayable, -> { where(is_displayable: true) }

  before_save :serialize_attrs
  # before_save :sanitize_emoticons

  DATA_ATTRIBUTES = [:standard_resolution_image_url,
                     :instagram_user_full_name,
                     :caption_text,
                     :instagram_user_id]

  def serialize_attrs
    self.tags = JSON.parse self.tags.to_json
    self.likes = JSON.parse self.likes.to_json
    self.images = JSON.parse self.images.to_json
    self.videos = JSON.parse self.videos.to_json
    self.caption = JSON.parse self.caption.to_json
    self.location = JSON.parse self.location.to_json
    self.comments = JSON.parse self.comments.to_json
    self.users_in_photo = JSON.parse self.users_in_photo.to_json
  end

  # def sanitize_emoticons
  #   self.username = EmojiSanitizer.parse username
  #   self.username = EmojiSanitizer.parse username
  # end

  %w(low_resolution thumbnail standard_resolution).each do |image_type|
    %w(url height width).each do |image_attribute|
      define_method "#{image_type}_image_#{image_attribute}" do
        images[image_type][image_attribute]
      end
    end
  end

  %w(likes comments users_in_photo).each do |field|
    define_method "#{field}_count" do
      field.size
    end
  end

  def caption_text
    caption['text']
  end

  def to_data
    DATA_ATTRIBUTES.reduce({}) do |result, field|
      result[field] = self.send(field)
      result
    end
  end

  def engagement
    likes_count
    # (LIKES_MULTIPLIER * likes_count) +
    #   (COMMENTS_MULTIPLIER * comments_count) +
    #   (USERS_IN_PHOTO_MULTIPLIER * users_in_photo_count)
  end

end
