# frozen_string_literal: true

class PdfGeneratorService
  LOGO_IMG_PATH = 'app/assets/images/logo.png'

  def initialize
    @pdf = Prawn::Document.new
    @document_width = @pdf.bounds.width
  end

  def header
    invoice_number = "Invoice #: ACS-04062024-222"
    date_issued = "Date: 04/06/2024"
    phone_label = "Phone:"
    email_label = "Email:"
  
    @pdf.bounding_box([0, @pdf.cursor], width: @document_width, height: 100) do
      if File.exist?(LOGO_IMG_PATH)
        @pdf.image LOGO_IMG_PATH, width: @document_width, height: 100
      end
    end

    @pdf.move_down 10

    @pdf.bounding_box([0, @pdf.cursor], width: @document_width) do
      @pdf.font('Helvetica', style: :bold, size: 14) do
        @pdf.text "INVOICE", align: :center
      end

      @pdf.move_down 10

      @pdf.font('Helvetica', size: 12) do
        @pdf.text date_issued, align: :right
        @pdf.text invoice_number, align: :right
      end
    end

    @pdf.move_down 10

    @pdf.font('Helvetica', size: 12) do
      @pdf.text phone_label, align: :left
      @pdf.text email_label, align: :left
    end
  end  

  def bill_to_section
    bill_to_data = [
      ["Bill To", "Port of Loading"],
      ["Name:", "PORT OF LOADING: Any Port of Japan"],
      ["Phone#:", "COUNTRY OF ORIGIN: Japan"],
      ["Email:", "INCOTERMS: 2010"],
      ["City:", "P.O.D:"],
      ["Country:", "COUNTRY:"]
    ]

    bill_to_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 0,
        padding: [5, 10]
      }
    }

    @pdf.table(bill_to_data, bill_to_options) do |table|
      table.row(0).font_style = :bold
      table.row(0).background_color = 'EDEFF5'
      table.row(0).size = 12
      table.row(1..-1).size = 10
    end
  end

  def vehicle_details_section
    vehicle_details_data = [
      ["No", "Vehicle Details"],
      ["1", "Maker", "MONTH / YEAR", "05/2013", "Engine size(cc)", "2000 cc"],
      ["2", "MODEL", "COLOR", "No of Seats", "5"],
      ["3", "MODEL CODE", "DBA-TB17", "Transmission", "AT", "Serial No"],
      ["4", "CHASIS NO", "Fuel", "PETROL"]
    ]

    vehicle_details_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 0.5,
        borders: [:bottom],
        border_color: 'c9ced5',
        padding: [5, 10]
      }
    }

    @pdf.table(vehicle_details_data, vehicle_details_options) do |table|
      table.row(0).font_style = :bold
      table.row(0).background_color = 'EDEFF5'
      table.row(0).size = 12
      table.row(1..-1).size = 10
    end
  end

  def payment_details_section
    payment_details_data = [
      ["Payment Details (Items)", "Details", "QTY", "AMOUNT"],
      ["1", "Car Price", "unit price", "1", "$ 0"],
      ["2", "Local Transportation", "1", "$ 0"],
      ["3", "Inspection", "1", "$ 0"],
      ["4", "Freight", "1", "$ 0"],
      ["5", "Insurance", "1", "$ 100"],
      ["6", "Late payment charges", "1", "$ 0"],
      ["7", "Demurrage Charges", "1", "$ 0"],
      ["8", "Repairing Fee", "1", "$ 0"],
      ["9", "Other", "1", "$ 0"]
    ]

    payment_details_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 0.5,
        borders: [:bottom],
        border_color: 'c9ced5',
        padding: [5, 10]
      }
    }

    @pdf.table(payment_details_data, payment_details_options) do |table|
      table.row(0).font_style = :bold
      table.row(0).background_color = 'EDEFF5'
      table.row(0).size = 12
      table.row(1..-1).size = 10
    end
  end

  def bank_details_section
    bank_details_data = [
      ["BANK DETAILS", "Discount", "$ 0"],
      ["PAYMENT TO", "Sirius Technologies"],
      ["BANK NAME", "Rakuten Bank"],
      ["BRANCH NAME", "Daiyon eigyou"],
      ["BRANCH CODE", "254"],
      ["SWIFT", "RAKTJPJT"],
      ["ACCOUNT NO", "7114917"],
      ["Total Payable", "$ 100"],
      ["Advance Payable", "$ 0"],
      ["Total Paid", "$ 0"],
      ["Remaining Amount", "$ 100"]
    ]

    bank_details_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 0.5,
        borders: [:bottom],
        border_color: 'c9ced5',
        padding: [5, 10]
      }
    }

    @pdf.table(bank_details_data, bank_details_options) do |table|
      table.row(0).font_style = :bold
      table.row(0).background_color = 'EDEFF5'
      table.row(0).size = 12
      table.row(1..-1).size = 10
    end
  end

  def generate_pdf
    header
    @pdf.move_down 20
    bill_to_section
    @pdf.move_down 20
    vehicle_details_section
    @pdf.move_down 20
    payment_details_section
    @pdf.move_down 20
    bank_details_section
    @pdf.render
  end
end
