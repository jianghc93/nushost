$(document).ready(function(){
    $('#delete_btn').on('click', function(e){
        e.preventDefault();
        var $form=$(this).closest('form');
        $('#myModal').modal({ backdrop: 'static', keyboard: false })
            .one('click', '#confirm_delete_btn', function() {
                $form.trigger('submit'); // submit the form
            });
        // (one. is not a typo of on.)
    });

})
