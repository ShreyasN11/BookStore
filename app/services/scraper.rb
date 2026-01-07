class Scraper
    BASE_URL = "https://openlibrary.org/search.json"

    def call
      response = Faraday.get(BASE_URL, {
        q: "Mumbai"
      })

      data = JSON.parse(response.body)
      save_books(data["docs"].take(10))
      Rails.logger.info "[Scraper] Finished successfully"
    rescue => e
      Rails.logger.error "[Scraper] Failed: #{e.message}"
    end

    private

    def save_books(books)
      books.each do |b|
        next if b["title"].blank?

        external_id = b["cover_edition_key"] || b["key"]

        next if external_id.blank?

        Book.find_or_create_by(isbn: external_id) do |book|
          book.title = b["title"]
          book.author = b["author_name"]&.first || "Unknown"
          book.published_year = b["first_publish_year"]
          book.description = "Imported from OpenLibrary"
          book.price = rand(300..900)
        end
      end
    end
end
