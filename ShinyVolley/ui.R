library(shinydashboard)

header <- dashboardHeader(title = "ShinyVolley Data Visualization")

sidebar <- dashboardSidebar(
  actionButton("update_btn", "Update"),
  uiOutput("setter_selector"),
  uiOutput("xkill_slider"),
  uiOutput("phase_selector"),
  uiOutput("mb_route_selector"),
  uiOutput("froh_selector"),
  uiOutput("frmb_selector"),
  uiOutput("frsopp_selector"),
  uiOutput("broh_selector"),
  uiOutput("brsopp_selector"),
  uiOutput("rotation_selector"),
  uiOutput("match_selector")
)

body <- dashboardBody(
  dataTableOutput("table")
)

# Define the user interface
ui <- dashboardPage(header, sidebar, body)