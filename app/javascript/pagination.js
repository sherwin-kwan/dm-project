import { Turbo } from '@hotwired/turbo-rails';

window.addEventListener('turbo:load', async (event) => {

  const limitSelector = document.querySelector("#limit-selector")
  if (limitSelector) {
    limitSelector.addEventListener('change', e => {
      const url = new URL(window.location.href)
      url.searchParams.set('limit', e.target.value)
      Turbo.visit(url.href)
    })
  }
  const pageSelector = document.querySelector("#page-selector")
  if (pageSelector) {
    pageSelector.addEventListener('change', e => {
      const url = new URL(window.location.href)
      url.searchParams.set('page', Number(e.target.value) - 1)
      Turbo.visit(url.href)
    })
  }

});

