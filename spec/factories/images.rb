module TestData
  module_function

  def image_data
    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)

    attacher.data # or attacher.data in case of postgres jsonb column
  end

  def uploaded_image
    file = File.open("spec/files/image.jpeg", binmode: true)

    # for performance we skip metadata extraction and assign test metadata
    uploaded_file = Shrine.upload(file, :store, metadata: false)
    uploaded_file.metadata.merge!(
      "size"      => File.size(file.path),
      "mime_type" => "image/jpeg",
      "filename"  => "image.jpeg",
      )

    uploaded_file
  end
end

FactoryBot.define do
  factory :image do
    name { Faker::Name.name }
    alt { Faker::Name.name }
    image_data { TestData.image_data }
  end
end
