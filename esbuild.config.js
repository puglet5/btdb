/* eslint-disable */

const path = require("path")
const rails = require("esbuild-rails")

require("esbuild").build({
  entryPoints: ["application.js"],
  bundle: true,
  minify: false,
  platform: 'browser',
  target: [
    'es2020',
  ],
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  watch: process.argv.includes("--watch"),
  plugins: [rails()],
}).catch(() => process.exit(1))
