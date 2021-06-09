dependency "rize_academy" client_script "@rize_academy/client.lua" fx_version "bodacious"
game "gta5"

ui_page_preload "yes"
ui_page "web-side/index.html"

client_scripts {
    "client-side/*"
}

files {
    "web-side/*"
}