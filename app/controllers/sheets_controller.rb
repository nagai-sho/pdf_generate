class SheetsController < ApplicationController

  def index
    @sheets = Sheet.all()
  end

  def new
    @sheet = Sheet.new()
  end

  def destroy
    sheet = Sheet.find(params[:id])
    sheet.destroy
    redirect_to root_path
  end
  
  def preview_pdf
    @sheet = Sheet.new(sheet_params) # formからのデータを受け取る

    if @sheet.valid? # 入力データが有効か確認
      generate_pdf_and_send(@sheet) # プレビュー用のPDFを生成・表示
    else
      render :new
    end
  end
  
  
  private
  
  def sheet_params
    params.require(:sheet).permit(:content)
  end
  
  def generate_pdf_and_send(sheet)
    @sheet = sheet

    respond_to do |format|
      format.html do
        # HTMLテンプレートのレンダリング
        html_content = render_to_string(template: 'sheets/show', layout: false)
        # HTMLを一時ファイルに保存
        html_path = Rails.root.join('tmp', 'new_sheet.html')
        File.write(html_path, html_content)
    
        # PDF生成
        pdf_service = PdfGeneratorService.new(html_path.to_s, Rails.root.join('tmp', 'new_sheet.pdf').to_s)
        pdf_service.generate_pdf
    
        # PDFをダウンロード
        send_file Rails.root.join('tmp', 'new_sheet.pdf'), type: 'application/pdf', disposition: 'inline'
      end
      format.turbo_stream { redirect_to root_path }
    end

  end

end
