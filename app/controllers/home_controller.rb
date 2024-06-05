class HomeController < ApplicationController
  def index
  end

  def generate_pdf
      pdf_service = PdfGeneratorService.new
      pdf_content = pdf_service.generate_pdf
      pdf_filename = "test.pdf"

      File.open('test.pdf', 'wb') { |file| file.write(pdf_content) }

      respond_to do |format|
          format.pdf do
          send_data pdf_content, filename: pdf_filename, type: 'application/pdf', disposition: 'attachment'
          end
      end
  end
end
