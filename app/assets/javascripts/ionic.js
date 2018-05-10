
function createNewSub() {
  swal({
    text: 'Enter Name of New Sub Type',
    content: "input",
    button: {
      text: "Add Sub Type",
      closeModal: false,
    },
  })
  .then(name => {
    if (!name) throw null;
    $.ajax({
       url:"/admin/add_sub_type?name=" + name,
       dataType: "JSON",
       success: function(data) {
         window.location.href = '/admin/sub_details?project_id=' + document.getElementById('p_id').innerHTML; 
       }
     });
   })
  .catch(err => {
    if (err) {
      swal("Oh noes!", "The AJAX request failed!", "error");
    } else {
      swal.stopLoading();
      swal.close();
    }
  });
}
