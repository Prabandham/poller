defmodule PollerWeb.PageControllerTest do
  use PollerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <meta name=\"description\" content=\"A simple Polling application.\">\n    <meta name=\"author\" content=\"Prabandham Srinidhi\">\n\n    <title>Poller - A polling application</title>\n\n    <link rel=\"stylesheet\" href=\"/css/app.css\">\n    <link rel=\"stylesheet\" href=\"https://srinidhiprabandham.github.io/static-assets/poller-landing-page.css\" >\n  </head>\n\n  <body>\n      <div class=\"container-fluid home-page\">\n        <div class=\"row\">\n          \n<section class=\"mbr-section mbr-section-hero mbr-section-full mbr-section-with-arrow mbr-parallax-background\" id=\"header1-0\" data-rv-view=\"7\" style=\"background-image: url(/images/mbr-810x1080.jpg);\">\n\n    <div class=\"mbr-overlay\" style=\"opacity: 0.5; background-color: rgb(0, 0, 0);\"></div>\n\n    <div class=\"mbr-table-cell\">\n\n        <div class=\"container\">\n            <div class=\"row\">\n                <div class=\"mbr-section col-md-6 col-md-offset-1 text-xs-center\">\n                    <h1 class=\"mbr-section-title display-3\">Poller</h1>\n                    <p class=\"mbr-section-lead lead\">A Simple polling Application.</p>\n                </div>\n\n                <div class=\"col-md-6\">\n\n                </div>\n            </div>\n        </div>\n    </div>\n\n    <div class=\"mbr-arrow mbr-arrow-floating\" aria-hidden=\"true\"><a href=\"#footer1-1\"><i class=\"mbr-arrow-icon\"></i></a></div>\n\n</section>\n\n<footer class=\"mbr-small-footer mbr-section mbr-section-nopadding\" id=\"footer1-1\" data-rv-view=\"12\" style=\"background-color: rgb(50, 50, 50); padding-top: 1.75rem; padding-bottom: 1.75rem;\">\n    <div class=\"container text-xs-center\">\n        <p>Copyright (c) 2018-19 Larks.</p>\n    </div>\n</footer>      </div>\n    <script src=\"/js/app.js\"></script>\n  </body>\n</html>\n"
  end

  test "GET /login", %{conn: conn} do
    conn = get(conn, "/login")
    assert html_response(conn, 200) =~ "<div id='login-form'>"
  end

  test "GET /register", %{conn: conn} do
    conn = get(conn, "/register")
    assert html_response(conn, 200) =~ "<div id='registration-form'>"
  end

  test "POST login with invlaid credentials should respond with error.", %{conn: conn} do
    conn = post(conn, auth_path(conn, :new), %{ login: %{login: "krishna", password: "password"} })
    assert html_response(conn, 200) =~ "<p class=\"alert alert-danger\" role=\"alert\">Invalid login credentials</p>"
  end
end
