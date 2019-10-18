# each student card .css("div.roster-cards-container .student-card")

require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profile = Nokogiri::HTML(open(index_url)).css("div.roster-cards-container .student-card")
    profile.reduce([]) do |profile_array, profile|
      profile_hash = {}
      profile_hash[:name] = profile.css("div.card-text-container h4.student-name").text
      profile_hash[:location] = profile.css("div.card-text-container p.student-location").text
      profile_hash[:profile_url] = profile.css("a").attribute("href").value
      profile_array << profile_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css("div.vitals-container div.social-icon-container").children.css("a").map { |a| a.attribute('href').value }
    profile_hash = links.reduce({}) do |link_hash, link|
      case 
      when link.include?("twitter")
        link_hash[:twitter] = link
      when link.include?("linkedin")
        link_hash[:linkedin] = link 
      when link.include?("github")
        link_hash[:github] = link
      else
        link_hash[:blog] = link
      end
      link_hash
    end
    profile_hash[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text.strip
    profile_hash[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder").text.strip
    profile_hash
  end

end


# Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")