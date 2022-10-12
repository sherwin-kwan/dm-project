# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "pagination"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tinymce", to: "https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js", preload: true