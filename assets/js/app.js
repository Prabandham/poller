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
    $(".vote-bar").on('click', function() {
        let progress_id = $(this).find(".progress-bar").attr('id')
        let answer_id = progress_id.split("_").pop()
        home_channel.push("vote", {answer_id: answer_id, user_id: window.user_id})
    });
});
