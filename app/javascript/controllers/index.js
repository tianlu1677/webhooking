// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

// import { Application } from "stimulus"
// import { definitionsFromContext } from "stimulus/webpack-helpers"


// const application = Application.start()
// const context = require.context("controllers", true, /_controller\.js$/)
// application.load(definitionsFromContext(context))
import { Application } from '@hotwired/stimulus'
import Clipboard from '@stimulus-components/clipboard'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// application.register('hello', HelloController)
application.register('clipboard', Clipboard)
