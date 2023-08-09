var pageForm = document.getElementById('pageForm');
var fName = document.getElementById('Fname');
var lName = document.getElementById('Lname');
var email = document.getElementById('Email');
var cwid = document.getElementById('CWID');
var phone = document.getElementById('Phone');
var pass = document.getElementById('Pass');
var pass2 = document.getElementById('Pass2');

var socket = new WebSocket('ws://127.0.0.1:7000');

socket.onerror = function(error) {
	console.log('WebSocket error: ' + error);
};

pageForm.onsubmit = function(e) {
    console.log("submitting");
    e.preventDefault();
    var goForward = 1;
    if (fName.value.length == 0){
        console.log("No first name given.");
        goForward = 0;
    }
    if (lName.value.length == 0){
        console.log("No last name given.");
        goForward = 0;
    }
    if (cwid.value.length == 0){
        console.log("No cwid given.");
        goForward = 0;
    }
    if (email.value.length == 0){
        console.log("No email given.");
        goForward = 0;
    }
    if (phone.value.length == 0){
        console.log("No phone number given.");
        goForward = 0;
    }
    if (pass.value != pass2.value){
        console.log("Passwords don't match.");
        goForward = 0;
    }

    if (goForward == 0){
        console.log("Fill missing sections and try again.");
        return 7;
    }


    var formData="Signup Attempt";
    formData = formData+fName.value+":," + lName.value+":," + cwid.value +":," + phone.value+":," + email.value + ":," + pass.value+":,"
    console.log("Sending: " +formData);
    socket.send(formData);

    socket.onmessage = function(e){
        var message = e.data.toString();
        if (message.includes("Success")){
            localStorage.setItem("tufCwid",cwid.value);
            window.location.href = "./TufFixIt.html";
        }
    }
}