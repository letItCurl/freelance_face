import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-to-clip-board"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (e) => { this.onclick(e) })
  }

  onclick(e) {
    e.preventDefault()
    navigator.clipboard.writeText(this.element.href);
    var originalHTML = this.element.innerHTML
    this.element.innerHTML = "Link Copied 📝"
    setTimeout(() => { this.element.innerHTML = originalHTML }, 750)
  }
}
