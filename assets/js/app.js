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
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(document).ready(function() {
    // First initialize bootstrap Material Design
    $('body').bootstrapMaterialDesign();

    // Remove container from landing page.
    if (window.location.href.split("/").pop() != "") {
        $($("body div:first-child")).removeClass("container-fluid");
        $($("body div:first-child")).addClass("container");
    }

    // If it is the Home page then set the width of the div to that of the page.
    if($(".home-page").length == 1) {
        var height = $(window).height();
        $(".home-page").height(height);
    }
    $(window).resize(function() {
        var height = $(window).height();
        $(".home-page").height(height);
    });

    //Toggle between Login and Register divs
    $('#show-reg-form').on('click', function() {
        $('#login-form').toggleClass('hidden');
        $('#registration-form').toggleClass('hidden');
    });
    $('#show-login-form').on('click', function() {
        $('#registration-form').toggleClass('hidden');
        $('#login-form').toggleClass('hidden');
    });
});
