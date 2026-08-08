import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.select = new window.TomSelect(this.element, {
      create: false,
      sortField: {
        field: "text",
        direction: "asc"
      },
      placeholder: "Digite para pesquisar..."
    })
  }

  disconnect() {
    if (this.select) {
      this.select.destroy()
    }
  }
}