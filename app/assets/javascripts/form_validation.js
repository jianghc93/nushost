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
                message: 'Please give your event a title',
                test: maxLength,
                arg: 50,
            },
            '#summary': {
                required: true,
                message: 'Please give a summary of what your event is about',
                test: maxLength,
                arg: 100
            },
            '#description': {
                required: true,
                message: 'Please give the details of your event'
            },
            '#date': {
                required: true,
                message: 'Please fill in a date'
            },
            '#time': {
                required: true,
                message: 'Please fill in time with the format 7:00 PM or 11:59 AM',
                test: time
            },
            '#venue': {
                required: true,
                message: 'Please give a venue for your event'
            }
        },
        unHappy: function () {
            $('#eventForm').submit(function(e){
                e.preventDefault();
                if ($('#title').val().length == 0)
                    $('#title').closest('.form-group').find('span')[0].innerHTML = "Please give your event a title";
                else if ($('#title').val().length != 0 &&  $('#title').val().length >= 50)
                    $('#title').closest('.form-group').find('span')[0].innerHTML = "Your title seems a little too long...";

                if ($('#summary').val().length == 0)
                    $('#summary').closest('.form-group').find('span')[0].innerHTML = "Please give a summary of what your event is about";
                else if ($('#summary').val().length >= 100)
                    $('#summary').closest('.form-group').find('span')[0].innerHTML = "Please keep the summary short and sweet";

                if ($('#time').val().length == 0)
                    $('#time').closest('.form-group').find('span')[0].innerHTML = "Please fill in time with the format 7:00 PM or 11:59 AM";
                else if (!time($('#time').val()))
                    $('#time').closest('.form-group').find('span')[0].innerHTML = "Please give a valid time";
            });
        }

    });


    function time(val) {
        valid_time =  /[1-9][:][0-5][0-9]\s(P||A)[M]/.test(val) ||
                      /[1][0-2][:][0-5][0-9]\s(P||A)[M]/.test(val);
        if(valid_time){
            return moment(val, ["h:mm A"]).isAfter(moment());
        } else {
            return false;
        }
    }

    function maxLength(val, length) {
        return val.length <= length;
    }

});
