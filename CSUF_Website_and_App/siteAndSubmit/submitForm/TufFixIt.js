var pageForm = document.getElementById('pageForm');
var emergency = document.getElementById('EmergencyYes');

var electrical = document.getElementById('ELECTRICAL');
var structural = document.getElementById('STRUCTURAL');
var hvac = document.getElementById('HVAC');
var waste = document.getElementById('HAZARDOUS/WASTE');
var safety = document.getElementById('SAFETY');
var plumbing = document.getElementById("PLUMBING/SEWER");
var water = document.getElementById('WATER/IRRIGATION');
var road = document.getElementById("ROAD");
var security = document.getElementById("SECURITY/FENCE");
var classroom = document.getElementById('CLASSROOM EQUIPMENT');
var otherType = document.getElementById('OTHER');

var location = document.getElementById('Location');
var description = document.getElementById('Comment');

// Creating a new WebSocket connection.
var socket = new WebSocket('ws://127.0.0.1:7000');


socket.onerror = function(error) {
	console.log('WebSocket error: ' + error);
};

pageForm.onsubmit = function(e) {
    e.preventDefault();
    var goForward = 1;

    if (goForward == 0){
        console.log("Fill missing sections and try again.");
        return 7;
    }


    // Recovering the message of the textarea.
    var initMsg = "submitting form Format is in the following format:\n" +
        "CWID, Location, Description, Category, Emergency?\n"+
        "Categorization order: Electrical, Structural, Hvac, Biohazard, Safety, Plumbing/Sewage, Water/Irrigation, Road, Security, Classroom, Other"
    
    // Sending the msg via WebSocket.

    var cwid = localStorage.getItem("tufCwid");
    socket.send(initMsg);
    var formData="Ticket Data:";
    
    formData= formData + (cwid + ":,");

    var emerge = "0";
    if (emergency.checked) emerge = "1";
    formData= formData + (emerge + ":,");

    if (electrical.checked) formData= formData +(1);
    else formData= formData + (0);
    if (structural.checked) formData= formData +(1);
    else formData= formData + (0);
    if (hvac.checked) formData= formData +(1);
    else formData= formData + (0);
    if (waste.checked) formData= formData +(1);
    else formData= formData + (0);
    if (safety.checked) formData= formData +(1);
    else formData= formData + (0);
    if (plumbing.checked) formData= formData +(1);
    else formData= formData + (0);
    if (water.checked) formData= formData +(1);
    else formData= formData + (0);
    if (road.checked) formData= formData +(1);
    else formData= formData + (0);
    if (security.checked) formData= formData +(1);
    else formData= formData + (0);
    if (classroom.checked) formData= formData +(1);
    else formData= formData + (0);
    if (otherType.checked) formData= formData +(1);
    else formData= formData + (0);
    formData = formData + ":,"
    
    formData = formData + (location.value + ":, ");

    formData = formData + (description.value);

    socket.send(formData);

    socket.onmessage = function(e){
        console.log(e.data);
        if (e.data.includes("recieved and logged.")){
            window.location.href = "./TufFixAck.html";
        }
        };
    
    return false;
};
