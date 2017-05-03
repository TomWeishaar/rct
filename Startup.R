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


# Erase bad hit list and go back to process search
# prj$hits = "empty"
# prj$sourceInfo$status = "new"
# prj$lastRid = 2
# save_prj()

# productivity charts
# # by day of week (needs to be sorted)
# barplot(table(weekdays(prj$reviews$time)), main = "Completed Reviews by Weekday")
# # by day of month (needs zero days added)
# barplot(table(day(prj$reviews$time)), main = "Completed Reviews by Day of Month")
# # by hour of day
# barplot(table(hour(prj$reviews$time)), main = "Completed Reviews by Hour of Day")
# # by date
# barplot(table(date(prj$reviews$time)), main = "Completed Reviews by Date")

# Move review notes into article comments...
# sum(duplicated(prj$reviews$Rid))
# sum(prj$reviews$comment!="")
# Rcmt = prj$reviews[prj$reviews$comment!="",]
# Rcmt = Rcmt[Rcmt$comment!="\n\n",]
# Rcmt = Rcmt[Rcmt$comment!="\n",]
# hits2 = prj$hits
# for(rid in Rcmt$Rid) {
#    hits2$comments[hits2$Rid == rid] = paste0(Rcmt$comment[Rcmt$Rid == rid], "\n", hits2$comments[hits2$Rid == rid])
# }
# prj$hits = hits2
# save_prj()

pRids = prj$reviews[prj$reviews$decision == "Stage 1 pass", "Rid"]
outcomes = prj$hits[prj$hits$Rid %in% pRids,c("Rid", "comments")]

outs = tibble(Rid=character(0), Outcomes=character(0))
i=1
for(rid in outcomes$Rid) {
   oc = str_split(str_split(outcomes$comments[outcomes$Rid == rid] , "#\n")[[1]][2], "\n")[[1]] # get outcomes
   oc = str_trim(oc[!oc %in% ""])                                                          # delete blank lines and trim blanks
   for(d in 1:length(oc)) {
      outs[i,"Rid"] = rid
      outs[i,"Outcomes"] = oc[d]
      i=i+1
   }
}
outs$dup = duplicated(outs$Outcomes)
outs2 = tibble(outcome=character(0), rids=character(0), n=numeric(0))
i=1
for(z in 1:length(outs$Rid)) {
   if(outs$dup[z]) {                                                  # this is a duplicate outcome
      x = which(outs2$outcome %in% outs$Outcomes[z])                  #    find this row in outs2
      outs2[x, "rids"] = paste0(outs2[x, "rids"], ", ", outs$Rid[z])  #    add this rid to string
      outs2[x, "n"] = outs2[x,"n"]+1                                  #    inc n
   } else {                                                           # first time for this outcome
      outs2[i,"outcome"] = outs$Outcomes[z]                           #    add a row to outs2
      outs2[i,"rids"] = outs$Rid[z]                                   #    init rid
      outs2[i,"n"] = 1                                                #    init n
      i=i+1                                                           #    get ready for next row
   }
}
outs2 = arrange(outs2, desc(n))
View(outs2)

