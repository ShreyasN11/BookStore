import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "card"]

  connect() {
    this.currentBookId = null
  }

  open(event) {
    event.preventDefault()
    this.currentBookId = event.currentTarget.dataset.bookId
    this.renderContent()
    this.overlayTarget.classList.remove("hidden")
  }

  close() {
    this.overlayTarget.classList.add("hidden")
    document.getElementById("modal_book_content").innerHTML = "Loading..."
  }

  next() {
    const ids = this.getVisibleIds()
    const currentIndex = ids.indexOf(this.currentBookId)
    const nextIndex = (currentIndex + 1) % ids.length
    this.currentBookId = ids[nextIndex]
    this.renderContent()
  }

  previous() {
    const ids = this.getVisibleIds()
    const currentIndex = ids.indexOf(this.currentBookId)
    const prevIndex = (currentIndex - 1 + ids.length) % ids.length
    this.currentBookId = ids[prevIndex]
    this.renderContent()
  }

  renderContent() {
    const frame = document.getElementById("modal_book_content")
    frame.src = `/books/${this.currentBookId}`
  }

  getVisibleIds() {
    return this.cardTargets.map(card => card.dataset.bookId)
  }
}