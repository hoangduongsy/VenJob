require "rubygems"
require "open-uri"
require "nokogiri"
require "mechanize"
require "pry"

namespace :job do
  desc "crawl data"
  task create: :environment do
    agent = Mechanize.new
    main_page = Nokogiri::HTML(open(URI.escape("https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-vi.html")))
    total_page = main_page.css("div.ais-stats").css("h1.col-sm-10").css("span").text.to_i
    (1..total_page).each do |num|
      page = agent.get("https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{num}-vi.html")
      links = page.links.select { |link| link.href.include?("careerbuilder.vn/vi/tim-viec-lam/") }.map(&:href)
      links.each do |link|
        puts link
        job_page = Nokogiri::HTML(open(URI.escape(link)))
        begin
          title = job_page.css("div.MyJobDetail").css("div.MyJobLeft").css("div.LeftJobCB").css("div.top-job").css("div.top-job-info").css("h1").text
          if job_page.css("div.LeftJobCB").present?
            description = job_page.css("div.LeftJobCB").css("div.MarBot20")[1].css("div.content_fck").css("p").text
            short_description = job_page.css("div.LeftJobCB").css('div.desc_company.content_fck').css('span#emp_collapse').text
            requirement = job_page.css("div.LeftJobCB").css("div.MarBot20")[2].css("div.content_fck").css("p").text
          elsif job_page.css("div.content_fck.content_job_info").present?
            description = job_page.css("div.content_fck.content_job_info").css("div.decs")[0].text
            requirement = job_page.css("div.content_fck.content_job_info").css("div.decs")[1].text
          elsif job_page.css("div.content_fck.job_requirement").present?
            description = job_page.css("div.content_fck.job_requirement").css("div")[0].text
            requirement = job_page.css("div.content_fck.job_requirement").css("div")[2].text
          elsif job_page.css("div.content_fck").present?
            description = job_page.css("div.content_fck")[0].css("p").text
            short_description = "N/A"
            requirement = job_page.css("div.content_fck")[1].css("p").text
          end

          salary = job_page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li.bgLine2").css("p.fl_right").text
          position = job_page.css("div#showScroll.box2Detail").css("ul.DetailJobNew").css("li.bgLine1").css("p.fl_left").text

        rescue
          logger = Rails.logger
          logger.info "Skip #{link}"
          next
        end

        post_code = /.([^.]*).html/.match(link)
        job = Job.find_or_initialize_by(code: post_code[1])
        job.update(
          title: title,
          description: description,
          short_description: short_description,
          salary: salary,
          requirement: requirement,
          position: position)
      end
    end
  end
end
