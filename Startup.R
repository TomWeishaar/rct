#### Start RCT.app
#
# v1.0 - TomW - 9/2/16

   # Clean up - gets rid of all user-defined objects save those that begin with "."
remove(list=objects())

   # Paths
project_path = getwd()
RCT_path = paste0(project_path, "/RCT.app/")

   # Basic Functions
# source(paste0(project_path, "/../NHANES/R Syntax Files/Functions/basic-v1.0.R"))    # hm(x); pstar(p); csv(table, filename); chgcolnames(df,olds, news)

   # Start Shiny
source(paste0(RCT_path, "app.R"))
shinyApp(ui = ui, server = server)

# Missing a way to declare duplicates for non-PMID cites
# Does hits need a "Rin" variable (used to identify the level 1 Rid that a level 2 cite appears in)?
# Add PMID filter? (replace Page?)
# Enhance search analysis
# Vitamin D wiki url processor?
# Hand entry of PMID search type
# Add a dialog for http errors; otherwise they lock up the stage 1 list
# On switching projects, more variables need to be cleared - Stage 1 Results for sure

### Opaque features
# During S1 Review, review comments aren't saved on studies that remain "Not reviewed", but article comments ARE saved.


# Open platform for continous online replication and updating of meta-analyses - Open-Meta


