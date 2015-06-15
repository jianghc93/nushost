$(document).ready(function(){


    //this event handler doesnt work if it is placed after isHappy...
    //$('#eventForm').submit(function(event){
      //  event.preventDefault();
    //});

    $('#eventForm').isHappy({
        fields: {
            // reference the field you're talking about, probably by `id`
            // but you could certainly do $('[name=name]') as well.
            '#title': {
                required: true,
                message: 'Please give your event a title'
            },
            '#summary': {
                required: true,
                message: 'Please give a summary of what your event is about'
            },
            '#description': {
                required: true,
                message: 'Please give the details of your event'
            },
            '#date': {
                required: true,
                message: 'Please give a valid date'
            },
            '#time': {
                required: true,
                message: 'Please give a valid time'
            },
            '#venue': {
                required: true,
                message: 'Please give a venue for your event'
            },
        }
        //unHappy: function(){
        //    alert('The form is not happy');
        //}
    });


    // When it's time to "submit" the form, it's easy
    //$("#eventForm").submit();

});
