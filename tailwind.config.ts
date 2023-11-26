import type { Config } from "tailwindcss"

module.exports = {
  darkMode: "class",
  plugins: [require("@tailwindcss/forms")],
  content: [
    "./app/views/**/*.html.erb",
    "./app/components/*",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./node_modules/flowbite/dist/datepicker.js"
  ],
  theme: {}
} satisfies Config
