class Scraper
  BASE_URL = "https://openlibrary.org/search.json"
  QUERY = "India"
  PER_DAY = 10

  def call
    state = ScraperState.find_by!(name: "openlibrary")
    next_page = state.last_page + 1

    response = Faraday.get(BASE_URL, {
      q: QUERY,
      page: next_page
    })

    data = JSON.parse(response.body)
    books = data["docs"].take(PER_DAY)

    save_books(books)

    state.update!(last_page: next_page)

    Rails.logger.info "[Scraper] Page #{next_page} scraped successfully"
  rescue StandardError => e
    Rails.logger.error "[Scraper] Failed: #{e.message}"
  end

  private

  def save_books(books)
    books.each do |b|
      next if b["title"].blank?

      external_id = b["cover_edition_key"] || b["key"]
      next if external_id.blank?

      book = Book.find_or_initialize_by(isbn: external_id)
      next if book.persisted?

      author_name = b["author_name"]&.first || "Unknown"
      author_name = author_name.strip

      author = Author.find_or_create_by!(name: author_name)

      book.title = b["title"]
      book.author = author
      book.published_year = b["first_publish_year"]
      book.description = "Imported from OpenLibrary"
      book.price = rand(300..900)

      book.save!
    end
  end
end
