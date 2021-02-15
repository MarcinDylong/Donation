$(document).ready(function () {
    $('input[type="checkbox"]').click(function () {
        let checkButton = [];
        let catName = [];
        $.each($('input[type="checkbox"]:checked'), function () {
            checkButton.push($(this).val());
            catName.push($(this).siblings()[1].innerHTML);
        });

        let radbox = $('.category-filter')

        function isMatch(checkButton, cat) {
            let ret = true
            for (var i=0; i<checkButton.length; i++) {
                if (cat.includes(checkButton[i])) {}
                else {
                    ret = false
                }
            }
            return ret;
        }

        for (var j = 0; j < radbox.length; j++) {
            let cat = JSON.parse(radbox[j].dataset['categories'])
            // if (checkButton in cat) {
            if (isMatch(checkButton,cat)) {
                // radbox[j][0].show();
                $.each($(radbox[j]), function () {
                    $(this).show()
                });
            } else {
                // radbox[j][0].hide();
                $.each($(radbox[j]), function () {
                    $(this).hide()
                });
            }
        }

        function IsFilled(value, message) {
                if (value === '') {
                    Swal.fire({
                        title: 'Błąd!\n',
                        text: message
                    })
                }
            }

        $('.summary').click(function () {
            let bagsQty = $('input#id_quantity').prop('value');
            let street = $('input#id_address').prop('value');
            let city = $('input#id_city').prop('value');
            let zipCode = $('input#id_zip_code').prop('value');
            let phoneNumber = $('input#id_phone_number').prop('value');
            let pickUpDate = $('input#id_pick_up_date').prop('value');
            let pickUpTime = $('input#id_pick_up_time').prop('value');
            let notes = $('input#id_notes').prop('value');
            let cat = $('input[type="checkbox"]:checked')
            let bagsCat = "Ilość: " + bagsQty + " Kategorie: " + catName.join(', ')
            let inst
            $.each($('.category-filter'), function () {
                if ($(this).find('input').is(':checked')) {
                    inst = $(this).find('div.title')[0].innerText;
                }
            })
            // console.log(bagsCat)
            $('#qty-cat').text(bagsCat);
            $('#inst').text(inst);
            $('#street').text(street);
            $('#city').text(city);
            $('#zip_code').text(zipCode);
            $('#phone_number').text(phoneNumber);
            $('#pick_up_date').text(pickUpDate);
            $('#pick_up_time').text(pickUpTime);
            $('#notes').text(notes);
            // Summary
            $('.submit').click(function () { 
                IsFilled(bagsQty, 'Uzupełnij ilość!');
                IsFilled(cat, 'Wybierz co chcesz przekazać!');
                IsFilled(inst, 'Wybierz instytucję!');
                IsFilled(street, 'Uzupełnij nazwę ulicy!');
                IsFilled(city, 'Uzupełnij nazwę miasta!');
                IsFilled(zipCode, 'Uzupełnij kod pocztowy!');
                IsFilled(pickUpDate, 'Uzupełnij dzień odbioru!');
                IsFilled(pickUpTime, 'Uzupełnij godzinę odbioru!');
                IsFilled(phoneNumber, 'Uzupełnij numer konraktowy!');
            })
        })
    })
});

