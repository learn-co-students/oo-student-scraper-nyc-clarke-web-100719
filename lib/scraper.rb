require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    temp_array =[]
    html = Nokogiri::HTML(open(index_url))
    html.css('div.student-card').each{|container| temp_array << {name: container.css('h4').text ,location: container.css('p').text ,profile_url: container.css('a').attribute('href').value}}
    temp_array
  end

  def self.scrape_profile_page(profile_url)
    temp_hash= {}
    html = Nokogiri::HTML(open(profile_url))
    html.css('div.social-icon-container a').each{|link|
     url = link.values[0]
     ck_pg = url.split(/www|\.|\/\//).reject{|e| e.size <= 0}[1]
    if ck_pg == "twitter" || ck_pg == "linkedin" || ck_pg == "github"
        temp_hash[ck_pg.to_sym] = url
    else
      temp_hash[:blog] = url
    end
    }
    temp_hash[:profile_quote] = html.css('div.profile-quote').text
    temp_hash[:bio] = html.css('div.bio-content.content-holder p').text
    temp_hash
    #{twitter: ,linkedin: ,github: ,blog: ,profile_quote: ,bio: }
  end

end

x = Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
#html.css('div.card-text-container').first
#html.css('div.card-text-container h4.student-name').first
