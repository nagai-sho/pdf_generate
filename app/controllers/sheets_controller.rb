class SheetsController < ApplicationController

  def index
    @sheets = Sheet.all()
  end

  def new
    @sheet = Sheet.new()
  end

  # def create
  #   @sheet = Sheet.create(sheet_params)
  #   if @sheet.save
  #     redirect_to root_path
  #   else
  #     render :new
  #   end
  # end

  def new_pdf
    @sheet = Sheet.new()
    html_content = render_to_string(template: 'sheets/new', layout: false)
    html_path = Rails.root.join('tmp', 'new_sheet.html')
    File.write(html_path, html_content)
    
    pdf_service = PdfGeneratorService.new(html_path.to_s, Rails.root.join('tmp', 'new_sheet.pdf').to_s)
    pdf_service.generate_pdf

    send_file Rails.root.join('tmp', 'new_sheet.pdf'), type: 'application/pdf', disposition: 'inline'
  end

  # private

  # def sheet_params
  #   params.require(:sheet).permit(:content)
  # end

end
