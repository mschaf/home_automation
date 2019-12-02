import jQuery from 'jquery'

import "clockpicker/dist/bootstrap-clockpicker.css"
import "clockpicker/dist/bootstrap-clockpicker.js"

//import "bootstrap/scss/bootstrap.scss"
import "font-awesome/scss/font-awesome.scss"

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("jquery")
require("unpoly")
require("chart.js")

$ = jQuery
window.$ = jQuery
window.jQuery = jQuery

// JavaScript
let webpackContext = require.context('../javascripts/blocks', true, /\.js$/)
for(let key of webpackContext.keys()) { webpackContext(key) }

// Images
require.context('../images', true, /\.(?:png|jpg|gif|ico|svg)$/)

// Stylesheets
require('../stylesheets/reset.sass')
require('../stylesheets/theme.sass')
require('../stylesheets/shared.sass')
require.context('../stylesheets/blocks', true, /\.sass$/)

