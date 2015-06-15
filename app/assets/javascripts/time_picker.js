$(document).ready(function(){

    $("label").click(function(){
        $(this).hide();
    });

    $('#time').datetimepicker({
        format: 'LT',
        widgetPositioning: {vertical:'top',  horizontal:'right'}
    });

    $('#date').datetimepicker({
        format: 'DD-MM-YYYY',
        widgetPositioning: {vertical:'top',  horizontal:'right'}
    });






});
