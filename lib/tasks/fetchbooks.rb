puts "Starting OpenLibrary scrape..."

Scraper.new.call

puts "Scraping completed at #{Time.now}"