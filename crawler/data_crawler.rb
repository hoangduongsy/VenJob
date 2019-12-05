require "rubygems"
require "open-uri"
require "nokogiri"
require "mechanize"
require "csv"
require "pry"

agent = Mechanize.new
main_page = Nokogiri::HTML(open(URI.escape("https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-vi.html")))
total_page = main_page.css("div.ais-stats").css("h1.col-sm-10").css("span").text.to_i
(1..total_page).each do |num|
  page = agent.get("https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{num}-vi.html")
  links = page.links.select { |link| link.href.include?("careerbuilder.vn/vi/tim-viec-lam/") }.map(&:href)
  links.each do |link|
    job_page = Nokogiri::HTML(open(URI.escape(link)))
    if (title1 = job_page.css("div.MyJobDetail").css("div.MyJobLeft").css("div.LeftJobCB").css("div.top-job").css("div.top-job-info").css("h1").text)
      puts title1
    # elseif
    #   (title2 = job_page.css("div.main_content_right").css("div.content_470").css("div.box_470").css("div.midle_tile").css("h1 p").text)
    #   puts title2
    # else
    #   puts job_page.css("div.col-xs-12 job-template-2").css("div.box-shadow col-xs-12 content-job-detail").css("div.col-xs-12 top-job").css("div.top-job-info").css("p")[0].text
    end

    #company_name
    puts job_page.css("div.MyJobDetail").css("div.MyJobLeft").css("div.LeftJobCB").css("div.top-job").css("div.tit_company").text

    #updated date
    puts job_page.css("div.datepost").text
    # puts job_page.css("div.datepost").css("span").text

    # #city_job
    # puts page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li")[0].css("b").css("a")[1].text

    #position
    puts job_page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li.bgLine1").css("p.fl_left").text

    # #experienced
    puts job_page.css("ul.DetailJobNew").css("li.bgLine2").css("p.fl_left").text

    # #salary
    puts job_page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li.bgLine2").css("p.fl_right").text

    #industry
    puts job_page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li.bgLine1").css("p.fl_left").css("b").css("a").text

    #expired_date
    puts job_page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li.bgLine1").css("p.fl_right").text

    #All job information related
    #job_description
    puts job_page.css("div.LeftJobCB").css("div.MarBot20").text
    # puts job_page.css("div.LeftJobCB").css("div.MarBot20").css("div.content_fck").css("p").text

    # detail company
    puts job_page.css("div.box1Detail").css("p.TitleDetailNew").css("label").text
  end
end
