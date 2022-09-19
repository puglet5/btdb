/* eslint-disable */

const colors = require('tailwindcss/colors')

module.exports = {
  darkMode: "class",
  plugins: [require('@tailwindcss/forms')],
  content: [
    './app/views/**/*.html.erb',
    './app/components/*',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {

  }
}
