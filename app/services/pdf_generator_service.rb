# frozen_string_literal: true

class PdfGeneratorService
  LOGO_IMG_PATH = 'app/assets/images/logo.png'
  FOOTER_LOGO_IMG_PATH = 'app/assets/images/footer_logo.png'

  def initialize
    @pdf = Prawn::Document.new
    @document_width = @pdf.bounds.width
  end

  def header
    invoice_number = "Invoice #: ACS-04062024-222"
    date_issued = "Date: 04/06/2024"
    phone_label = "Phone:"
    email_label = "Email:"
  
    @pdf.bounding_box([0, @pdf.cursor], width: @document_width, height: 60) do
      if File.exist?(LOGO_IMG_PATH)
        @pdf.image LOGO_IMG_PATH, width: @document_width, height: 60
      end
    end

    @pdf.move_down 5

    @pdf.bounding_box([0, @pdf.cursor], width: @document_width) do
      @pdf.font('Helvetica', style: :bold, size: 12) do
        @pdf.text "INVOICE", align: :center
      end

      @pdf.move_down 5

      @pdf.font('Helvetica', size: 10) do
        @pdf.text date_issued, align: :right
        @pdf.text invoice_number, align: :right
      end
    end

    @pdf.move_down 5

    @pdf.font('Helvetica', size: 10) do
      @pdf.text phone_label, align: :left
      @pdf.text email_label, align: :left
    end
  end  

  def bill_to_section
    bill_to_data = [
      [{ content: "Bill To", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right] },
       { content: "Port of Loading", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right] }],
      ["Name:", "PORT OF LOADING: \t Any Port of Japan"],
      ["Phone#:", "COUNTRY OF ORIGIN: \t Japan"],
      ["Email:", "INCOTERMS: \t 2010"],
      ["City:", "P.O.D:"],
      ["Country:", "COUNTRY:"]
    ]
  
    bill_to_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 1,
        border_color: '000000',
        padding: [3, 5]
      }
    }
  
    @pdf.table(bill_to_data, bill_to_options) do |table|
      table.row(0).each do |cell|
        cell.background_color = 'D3D3D3'
        cell.font_style = :bold
        cell.size = 10
        cell.align = :center
        cell.padding = [5, 5, 5, 5]
        cell.borders = [:top, :bottom, :left, :right]
      end
  
      table.row(0).column(0).borders = [:top, :bottom, :left, :right]
      table.row(0).column(1).borders = [:top, :bottom, :left, :right]
  
      table.row(1..-1).border_top_width = 0
      table.row(1..-1).border_bottom_width = 0
      table.row(1..-1).border_left_width = 0
      table.row(1..-1).border_right_width = 0
    end
  end

  def vehicle_details_section
    vehicle_details_data = [
      [{ content: "No", background_color: 'D3D3D3', borders:  [:top, :bottom, :left, :right], padding: [3, 5], font_style: :bold, size: 10 }, { content: "Vehicle Details", background_color: 'D3D3D3', align: :center ,borders:  [:top, :bottom, :left, :right], colspan: 6, padding: [3, 5], font_style: :bold, size: 10 }],
      ["1", "Maker", "", "MONTH / YEAR", "05/2013", "Engine size(cc)", "2000 cc"],
      ["2", "MODEL", "", "COLOR", "", "No of Seats", "5"],
      ["3", "MODEL CODE", "DBA-TB17", "Transmission", "AT", "Serial No", ""],
      ["4", "CHASIS NO", "", "Fuel", "PETROL", "", ""]
    ]
  
    vehicle_details_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 1,
        borders:  [:top, :bottom, :left, :right],
        border_color: '000000',
        padding: [3, 5]
      }
    }
  
    @pdf.table(vehicle_details_data, vehicle_details_options) do |table|
      table.row(0).borders =  [:top, :bottom, :left, :right]
      table.row(-1).borders =  [:top, :bottom, :left, :right]
  
      table.row(0).column(0).borders =  [:top, :bottom, :left, :right]
      table.row(0).column(1..-1).borders =  [:top, :bottom, :left, :right]
  
      table.row(0).font_style = :bold
      table.row(0).background_color = 'D3D3D3'
      table.row(0).size = 10
      table.row(1..-1).size = 8
    end
  end

  def payment_details_section
    payment_details_data = [
      [ 
        { content: "", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], font_style: :bold, size: 10 },
        { content: "Payment Details (Items)", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], colspan: 4, padding: [3, 5], font_style: :bold, size: 10 },
        { content: "Details", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], padding: [3, 5], font_style: :bold, size: 10 },
        { content: "QTY", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], padding: [3, 5], font_style: :bold, size: 10 },
        { content: "AMOUNT", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], padding: [3, 5], font_style: :bold, size: 10 }],
      ["1", { content: "Car Price", colspan: 4 }, "unit price","1", "$ 0"],
      ["2", { content: "Local Transportation", colspan: 4 }, "","1", "$ 0"],
      ["3", { content: "Inspection", colspan: 4 }, "","1", "$ 0"],
      ["4", { content: "Freight", colspan: 4 }, "","1", "$ 0"],
      ["5", { content: "Insurance", colspan: 4 }, "","1", "$ 100"],
      ["6", { content: "Late payment charges", colspan: 4 }, "","1", "$ 0"],
      ["7", { content: "Demurrage Charges", colspan: 4 }, "","1", "$ 0"],
      ["8", { content: "Repairing Fee", colspan: 4 }, "","1", "$ 0"],
      ["9", { content: "Other", colspan: 4 }, "","1", "$ 0"]
    ]
  
    payment_details_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 1,
        borders: [:top, :bottom, :left, :right],
        border_color: '000000',
        padding: [3, 5]
      }
    }
  
    @pdf.table(payment_details_data, payment_details_options) do |table|
      table.row(0).borders = [:top, :bottom, :left, :right]
      table.row(0).font_style = :bold
      table.row(0).background_color = 'D3D3D3'
      table.row(0).size = 10  
      table.row(1..-1).size = 8
    end
  end
  
  def bank_details_section
    bank_details_data = [
      [
        { content: "BANK DETAILS", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], align: :center, colspan: 4 ,padding: [3, 5], font_style: :bold, size: 10 },
        { content: "Discount", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], align: :center, padding: [3, 5], font_style: :bold, size: 10 },
        { content: "$ 0", background_color: 'D3D3D3', borders: [:top, :bottom, :left, :right], align: :center, padding: [3, 5], font_style: :bold, size: 10 }],
      ["PAYMENT TO", { content: "Sirius Technologies", colspan: 3 }, "Total Payable", { content: "$ 100" }],
      ["BANK NAME", { content: "Rakuten Bank", colspan: 3 }, "Advance Payable", { content: "$ 0" }],
      ["BRANCH NAME", { content: "Daiyon eigyou", colspan: 3 }, "Total Paid", { content: "$ 0" }],
      ["BRANCH CODE", { content: "254", colspan: 3 }, "Remaining Amount", { content: "$ 100" }],
      ["SWIFT", { content: "RAKTJPJT", colspan: 3 }, "", ""],
      ["ACCOUNT NO", { content: "7114917", colspan: 3 },"", ""],
    ]
  
    bank_details_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 1,
        borders: [:top, :bottom, :left, :right],
        border_color: '000000',
        padding: [3, 5]
      }
    }
  
    @pdf.table(bank_details_data, bank_details_options) do |table|
      table.row(0).borders = [:top, :bottom, :left, :right]
      table.row(0).font_style = :bold
      table.row(0).background_color = 'D3D3D3'
      table.row(0).size = 10
      table.column(0).font_style = :bold
      table.column(2).font_style = :bold
      table.column(2).background_color = 'D3D3D3'

      table.row(1..-1).size = 8
    end

    @pdf.move_down 5
    @pdf.font('Helvetica', size: 10) do
      @pdf.text 'If you have any questions about this invoice, please contact inquiry@otoz.ai', align: :left
    end
  end

  def footer
  
    @pdf.bounding_box([0, @pdf.cursor], width: @document_width, height: 60) do
      if File.exist?(LOGO_IMG_PATH)
        @pdf.image FOOTER_LOGO_IMG_PATH, width: @document_width, height: 60
      end
    end
  end  
  
  def generate_pdf
    header
    @pdf.move_down 5
    bill_to_section
    @pdf.move_down 5
    vehicle_details_section
    payment_details_section
    bank_details_section
    @pdf.move_down 5
    footer
    @pdf.render
  end
end
