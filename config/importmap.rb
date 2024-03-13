# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap" # @5.3.2
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js" # @2.11.8

# pin "filepond" # @4.30.6
# pin "filepond-plugin-image-preview" # @4.6.12
# pin "filepond-plugin-file-validate-type" # @1.2.8
#
# # config/importmap.rb
pin "filepond", to: "filepond/dist/filepond.min.js"
pin_all_from "app/javascript/custom", under: "custom"
pin "filepond-plugin-image-preview", to: "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.js"
pin "filepond-plugin-file-validate-type", to: "filepond-plugin-file-validate-type/dist/filepond-plugin-file-validate-type.min.js"
