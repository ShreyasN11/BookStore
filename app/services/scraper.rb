class Scraper
    BASE_URL = "https://openlibrary.org/search.json"
  
    def call
      response = Faraday.get(BASE_URL, {
        q: "India"
      })
  
      data = JSON.parse(response.body)
      save_books(data["docs"].take(10))
    end
  
    private
  
    def save_books(books)
      books.each do |b|
        next if b["title"].blank?
  
        # Use cover_edition_key as unique identifier
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
  