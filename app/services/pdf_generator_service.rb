class PdfGeneratorService
  def initialize(templete_path, output_path)
    @templete_path = templete_path
    @output_path = output_path
  end
  
  def generate_pdf
    browser = Ferrum::Browser.new
    browser.goto("file://#{@template_path}")
    browser.pdf(path: @output_path)
    browser.quit
  end
end
