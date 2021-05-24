// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "core-js/stable"
import 'bootstrap'
import "@coreui/coreui"
import './application.scss'
import "controllers"
const ClipboardJS = require('clipboard')


global.$ = require("jquery")

require("jquery") // Don't really need to require this...
require("jquery-ui")

import toastr from 'toastr';
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
const Rails = require("@hotwired/turbo-rails")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


window.Rails = Rails


$(document).on("turbo:load", () => {
  console.log("turbo!")
  const clipboard = new ClipboardJS('.copy')
  clipboard.on('success', function(e) {
    console.info('Action:', e.action);
    console.info('Text:', e.text);
    console.info('Trigger:', e.trigger);
    // toastr.success('xxx')
  });
  // $('[data-toggle="tooltip"]').tooltip()
  // $('[data-toggle="popover"]').popover()
})