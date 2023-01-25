const uploadHandler = async function (blobInfo, progress) {

  // First, use the back end to generate a presigned URL
  const data = await fetch("/get_presigned_url", {
    method: "GET",
  });
  const json = await data.json();
  const { presigned_url } = json;
  
  return new Promise(async (resolve, reject) => {

    try {
      const { url } = await fetch(presigned_url, {method: 'PUT', body: blobInfo.blob()});
      resolve(url.split("?")[0]) 
    } catch (err) {
      reject({
        message: `Image upload failed: ${err.message}`,
        remove: true
      })
    }
  });
};

window.addEventListener("turbo:load", async (event) => {
  tinymce.remove(); // Important! Turbo sometimes skips this code if it thinks TinyMCE has been init-ed already.
  // Remove and init to force it to render the editor every time you load a new page.
  tinymce.init({
    selector: ".tinymce",
    height: 500,
    menubar: false,
    plugins: [
      "a11ychecker",
      "advlist",
      "advcode",
      "advtable",
      "autolink",
      "checklist",
      "export",
      "lists",
      "link",
      "image",
      "charmap",
      "preview",
      "anchor",
      "searchreplace",
      "visualblocks",
      "powerpaste",
      "fullscreen",
      "formatpainter",
      "insertdatetime",
      "media",
      "table",
      "help",
      "wordcount",
    ],
    toolbar:
      "undo redo | casechange blocks | bold italic backcolor | " +
      "alignleft aligncenter alignright alignjustify | image | " +
      "bullist numlist checklist outdent indent | removeformat | a11ycheck code table help",
    image_title: true,
    file_picker_types: "image",
    file_picker_callback: (cb, value, meta) => {
      const input = document.createElement("input");
      input.setAttribute("type", "file");
      input.setAttribute("accept", "image/*");

      input.addEventListener("change", function () {
        const file = this.files[0];
        const reader = new FileReader();
        reader.onload = () => {
          /*
            Note: Now we need to register the blob in TinyMCEs image blob
            registry. In the next release this part hopefully won't be
            necessary, as we are looking to handle it internally.
          */
          const id = "blobid" + new Date().getTime();
          const blobCache = tinymce.activeEditor.editorUpload.blobCache;
          const base64 = reader.result.split(",")[1];
          const blobInfo = blobCache.create(id, file, base64);
          blobCache.add(blobInfo);
          /* call the callback and populate the Title field with the file name */
          cb(blobInfo.blobUri(), { title: file.name });
        };
        reader.readAsDataURL(file);
      });

      input.click();
    },
    images_upload_handler: uploadHandler,
  });
});
