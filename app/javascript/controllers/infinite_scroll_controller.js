import { Controller } from "@hotwired/stimulus"
import Rails from '@rails/ujs';

// Connects to data-controller="infinite-scroll"
export default class extends Controller {
  static targets = [ "entries", "pagination" ]

  scroll() {
    let nextPage = this.paginationTarget.querySelector("a[rel='next']")

    if (nextPage == null) {
      return
    }

    let url = nextPage.href

    let body = document.body,
      html = document.documentElement

    // console.log(body);
    // console.log(html);

    let height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    // console.log(scrollY);
    // console.log(height);
    // console.log(window.innerHeight);


    if (window.pageYOffset >= height - window.innerHeight - 100) {
      this.loadMore(url);
    }
  }

  loadMore(url) {
    Rails.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: (data) => {
        this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
        this.paginationTarget.innerHTML = data.pagination
      }
    })
  }
}
