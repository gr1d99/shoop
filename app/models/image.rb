<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> 9953ab3 (feat: add file uploader)
class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :imageable, polymorphic: true
end
