import { Controller } from "stimulus"
import PerfectScrollbar from 'perfect-scrollbar';


export default class extends Controller {
  connect() {
    this.initScroll()
  }

  initScroll() {
    const container = document.querySelector('#request_detail');
    const ps = new PerfectScrollbar(container);
  }
}
