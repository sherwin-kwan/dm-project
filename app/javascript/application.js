// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "pagination"
import "tinymce"


window.addEventListener('turbo:load', async (event) => {
  tinymce.remove() // Important! Turbo sometimes skips this code if it thinks TinyMCE has been init-ed already. 
  // Remove and init to force it to render the editor every time you load a new page.
  tinymce.init({
    selector: '.tinymce',
    height: 500,
    menubar: false,
    plugins: [
      'a11ychecker','advlist','advcode','advtable','autolink','checklist','export',
      'lists','link','image','charmap','preview','anchor','searchreplace','visualblocks',
      'powerpaste','fullscreen','formatpainter','insertdatetime','media','table','help','wordcount'
    ],
    toolbar: 'undo redo | casechange blocks | bold italic backcolor | ' +
      'alignleft aligncenter alignright alignjustify | ' +
      'bullist numlist checklist outdent indent | removeformat | a11ycheck code table help'
  });
})