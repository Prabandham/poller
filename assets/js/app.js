// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

$(document).ready(function() {
    // First initialize bootstrap Material Design
    $('body').bootstrapMaterialDesign();

    // If it is the Home page then set the width of the div to that of the page.
    if($(".home-page").length == 1) {
        var height = $(window).height();
        $(".home-page").height(height);
    }
    $(window).resize(function() {
        var height = $(window).height();
        $(".home-page").height(height);
    });

    // Set user's id to a variable in JS as this will be needed to make posts.
    window.user_id = $("#user_id").text();

    // Voting for a poll by a user.
    $("body").on('click', '.vote-bar', function() {
        let progress_id = $(this).find(".progress-bar").attr('id')
        let answer_id = progress_id.split("_").pop()
        home_channel.push("vote", {answer_id: answer_id, user_id: window.user_id})
    });

    // New Poll Form, add filds dynamically.
    let next = 1;
    $(".add-more").click(function(e){
        e.preventDefault();
        var addto = "#field" + next;
        var addRemove = "#field" + (next);
        if(next == 6) {
            $("#answer_limit_reached").removeClass("d-none")
            return
        }
        next = next + 1;
        var newIn = '<input autocomplete="off" class="input" id="field' + next + '" name="answers[]" type="text">';
        var newInput = $(newIn);
        var removeBtn = '<button id="remove' + (next - 1) + '" class="btn btn-danger remove-me" >-</button></div><div id="field">';
        var removeButton = $(removeBtn);
        $(addto).after(newInput);
        $(addRemove).after(removeButton);
        $("#field" + next).attr('data-source',$(addto).attr('data-source'));
        $("#count").val(next);  
            $('.remove-me').click(function(e){
                e.preventDefault();
                var fieldNum = this.id.charAt(this.id.length-1);
                var fieldID = "#field" + fieldNum;
                $(this).remove();
                $(fieldID).remove();
            });
    });

    // Save poll form
    $("#save-poll").on('click', function() {
        // TODO also append a new card to the starting of the div of cards and may be animate this as well.
        // TODO also get tags from the Web UI
        var values = $("#new_poll").serializeArray()
        $.get('/new_poll', values).then(function(data) {
            console.log(data);
            if(data.status == "success") {
                $("#newPollModal").addClass('animated fadeOutDown');
                $("[data-dismiss=modal]").trigger({ type: "click" });
                $("#newPollModal").removeClass('animated fadeOutDown');
            } else {
                alert("Some thing went wront in saving the poll. Please try again.")
            }
        })
    });
});
