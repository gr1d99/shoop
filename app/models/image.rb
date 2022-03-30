class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :imageable, polymorphic: true
end
