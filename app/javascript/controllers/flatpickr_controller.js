import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { Japanese } from "flatpickr/dist/l10n/ja.js";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      dateFormat: "Y-m-d",
      altInput: true,
      altFormat: "Y年m月d日 (D)",
      locale: Japanese,
    });
  }
}
