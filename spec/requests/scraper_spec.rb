require "rails_helper"

RSpec.describe ScrapeJob, type: :job do
  it "runs the scraper" do
    scraper = instance_double(Scraper)
    allow(Scraper).to receive(:new).and_return(scraper)
    allow(scraper).to receive(:call)
    ScrapeJob.perform_async
    expect(scraper).to have_received(:call)
  end
end
