class ScrapeJob
    include Sidekiq::Job
  
    sidekiq_options retry: 3, queue: 'default'
  
    def perform
      Scraper.new.call
    end
  end