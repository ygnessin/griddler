require 'action_dispatch'

module Griddler::Testing
  def upload_1
    @upload_1 ||= UploadedImage.new('photo1.jpg').file
  end

  def upload_2
    @upload_2 ||= UploadedImage.new('photo2.jpg').file
  end

  def normalize_params(params)
    Griddler::Sendgrid::Adapter.normalize_params(params)
  end

  class UploadedImage
    def initialize(name)
      @name = name
    end

    def file
      ActionDispatch::Http::UploadedFile.new({
        filename: @name,
        type: 'image/jpeg',
        tempfile: fixture_file
      })
    end

    private

    def fixture_file
      cwd = File.expand_path File.dirname(__FILE__)
      File.new(File.join(cwd, '..', '..', 'spec', 'fixtures', @name))
    end
  end
end
