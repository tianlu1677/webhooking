import './admin/style.scss'
import "core-js/stable"
import 'bootstrap'
import "@coreui/coreui"
import toastr from 'toastr';
import queryString from 'query-string'
window.queryString = queryString
import ReactDOM from 'react-dom'

// https://chartkick.com/
require("chartkick")
require("chart.js")


window.toastr = toastr;
var Turbolinks = require("turbolinks")
Turbolinks.start()

require('jquery');

$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr('content');
  xhr.setRequestHeader('X-CSRF-Token', token);
});
window.Rails = require("@rails/ujs")
window.Rails.start()

// var componentRequireContext = require.context("components", true);
// var ReactRailsUJS = require("react_ujs");
// ReactRailsUJS.useContext(componentRequireContext);

// turbolinks 加载的事件或者使用 stimulus
document.addEventListener("turbolinks:load", function () {
  $(".search_form select").addClass('form-control');
})