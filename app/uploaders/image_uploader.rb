# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  LARGE_MAX_SIDE_LENGTH = 554

  # Choose what kind of storage to use for this uploader:
    storage :file

    def cache_dir
      "#{Rails.root}/tmp/uploads"
    end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  # Set the mime type (will be based on the file extension, which is more accurate than what's in the request header)
  include CarrierWave::MimeTypes
  process :set_content_type

  # Create thumbnail for images and PDFs
  version :thumb, :if => :thumbable? do
    process :resize_to_fit => [140, 140], :if => :image?
    process :pdf_preview => [140, 140], :if => :pdf?
    process :get_geometry
  
    def geometry
      @geometry
    end
  
    # We need to change the extension for PDF thumbnails to '.jpg'
    def full_filename(filename)
      if filename.include? '.pdf'
        filename.gsub! '.pdf' '.jpg'      
      end
      "thumb_#{filename}"
    end
  end

  def pdf_preview(width, height)
    # Most PDFs have a transparent background, which becomes black when converted to jpg.
    # To override this, we must create a white canvas and composite the PDF onto the convas.
    # Read in first page of PDF and resize ([0] -> read the first page only)
    image = ::Magick::Image.read("#{current_path}[0]").first
    image.resize_to_fit!(width, height)
    # Create a blank canvas
    canvas = ::Magick::Image.new(image.columns, image.rows) { self.background_color = "#FFF" }
    # Merge PDF thumbnail onto canvas
    canvas.composite!(image, ::Magick::CenterGravity, ::Magick::OverCompositeOp)
    # Save as .jpg. We need to change the file extension here so that the fog gem picks it up and
    # sets the correct mime type. Otherwise the mime type will be set to PDF, which confuses browsers.
    canvas.write("jpg:#{current_path}")
    file.move_to current_path.gsub('.pdf', '.jpg')
    # Free memory allocated by RMagick which isn't managed by Ruby
    image.destroy!
    canvas.destroy!
  rescue ::Magick::ImageMagickError => e
    Rails.logger.error "Failed to create PDF thumbnail: #{e.message}"
    raise CarrierWave::ProcessingError, "is not a valid PDF file"
  end

  # Extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png pdf doc docx txt mp3 xls xlsx)
  end

  private
  
    def thumbable?(file)
      image?(file) || pdf?(file)
    end
  
    def image?(file)
      # Check the model first (see https://github.com/carrierwaveuploader/carrierwave/issues/1315)
      !file.content_type.include? 'pdf'
    end

    def pdf?(file)
      # Check the model first (see https://github.com/carrierwaveuploader/carrierwave/issues/1315)
      file.content_type.include? 'pdf'
    end

    def get_geometry
      if (@file)
        img = ::Magick::Image::read(@file.file).first
        @geometry = { :width => img.columns, :height => img.rows }
      end
    end
end

