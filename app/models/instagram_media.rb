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
#

class InstagramMedia < ActiveRecord::Base

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

  before_save :serialize_attrs

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

  %w(low_resolution thumbnail standard_resolution).each do |image_type|
    %w(url height width).each do |image_attribute|
      define_method "#{image_type}_image_#{image_attribute}" do
        images[image_type][image_attribute]
      end
    end
  end

  def caption_text
    caption['text']
  end

end
