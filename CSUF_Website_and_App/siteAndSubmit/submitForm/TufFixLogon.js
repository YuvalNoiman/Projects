var pageForm = document.getElementById('pageForm');
var email = document.getElementById('Email');
var pass = document.getElementById('Pass');

var socket = new WebSocket('ws://127.0.0.1:7000');




socket.onerror = function(error) {
	console.log('WebSocket error: ' + error);
};

pageForm.onsubmit = function(e) {
    e.preventDefault();
    var formData = "Login Attempt:" +email.value+":,"+pass.value
    socket.send(formData);
    socket.onmessage = function(e){
        console.log(e.data);
        var message = e.data.toString();
        if(message.includes("Valid")){
            var cwid = message.substring(12,);
            localStorage.setItem("tufCwid", cwid);
            window.location.href = "./TufFixIt.html";
        }
        else if (message.includes("Incorrect")){
            document.getElementById("secretP").textContent = "Invalid Login/Password";
        }

    }
}
