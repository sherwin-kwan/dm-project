import { Controller } from "@hotwired/stimulus"
import { Turbo } from '@hotwired/turbo-rails'

export default class extends Controller {
  connect() {
    
  }
  getpage(e) {
    console.log("Getting a new page!", e)
    const url = new URL(window.location.href)
    url.searchParams.set('page', Number(e.target.value) - 1)
    Turbo.visit(url.href, {action: "advance"})
  }
}
