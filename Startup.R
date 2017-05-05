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

new_names = matrix(ncol=2, byrow=TRUE, data=c(
   "Hamilton Depression Rating Scale (HDRS)", "depression",
   "Beck Depression Inventory (BDI)", "depression",
   "Beck Depression Inventory (BDI)-II", "depression",
   "Depression-Dejection", "depression",
   "Hospital Anxiety and Depression Scale", "depression",
   "Visual analogue scale (VAS) scores of pain perception", "pain",
   "pain scores", "pain",
   "Pain Assessment in Advanced Dementia Scale", "pain",
   "back pain", "pain",
   "knee pain severity (WOMAC pain scale)", "pain",
   "pain (visual analog scale score)", "pain",
   "IL-6", "inflammation",
   "IL-10", "inflammation",
   "frequency of circulating IL17+CD4+T helper cells", "inflammation",
   "IL-2 mRNA", "inflammation",
   "IL-8", "inflammation",
   "Der p 1-induced IL-10", "inflammation",
   "IL-1ß", "inflammation",
   "MCP-1", "inflammation",
   "TNFa", "inflammation",
   "TNF-a", "inflammation",
   "TNFα", "inflammation",
   "TNF-α", "inflammation",
   "tumour necrosis factor (TNF)-α", "inflammation",
   "tumor necrosis factor alpha (TNFα)", "inflammation",
   "tumor necrosis factor alpha (TNFa)", "inflammation",
   "Tumor necrosis factor (TNF)-alpha", "inflammation",
   "stimulated tumor necrosis factor (TNF)", "inflammation",
   "tumour necrosis factor (TNF)-a", "inflammation",
   "tumor necrosis factor-alpha", "inflammation",
   "tumor necrosis factor alpha", "inflammation",
   "serum amyloid A (SAA)", "inflammation",
   "circulating inflammatory markers", "inflammation",
   "fibrinogen", "inflammation",
   "retinol binding protein-4", "inflammation",
   "serum adiponectin ", "inflammation",
   "adiponectin", "inflammation",
   "retinol binding protein", "inflammation",
   "proinflammatory cytokines", "inflammation",
   "systemic inflammatory biomarkers", "inflammation",
   "circulating inflammatory markers", "inflammation",
   "interleukin (IL)-10", "inflammation",
   "interleukin 10", "inflammation",
   "interleukin 6 (IL-6)", "inflammation",
   "interleukin-6", "inflammation",
   "interleukin (IL)-13", "inflammation",
   "interleukin(IL)-2", "inflammation",
   "cholesterol (TTL, TG, LDL, HDL)", "lipid profile",
   "cholesterol", "lipid profile",
   "24-h ambulatory blood pressure (24-h BP)", "blood pressure",
   "central BP (cBP)", "blood pressure",
   "Central systolic blood pressure (cSBP)", "blood pressure",
   "24-hour systolic BP", "blood pressure",
   "24-hour diastolic BP", "blood pressure",
   "S&D blood pressure", "blood pressure",
   "24-h ambulatory blood pressure (24-h BP)", "blood pressure",
   "Central systolic blood pressure (cSBP)", "blood pressure",
   "calcium", "Ca",
   "ionized calcium", "Ca",
   "serum calcium", "Ca",
   "Serum calcium", "Ca",
   "serum albumin-corrected calcium (S-Ca)", "Ca",
   "plasma calcium", "Ca",
   "serum ionized calcium", "Ca",
   "CA", "Ca",
   "serum Ca", "Ca",
   "blood Ca", "Ca",
   "hair Ca", "Ca",
   "Ca,", "Ca",
   "adjusted calcium", "Ca",
   "Ca - Serum and Urine", "Ca",
   "urinary calcium", "U-Ca",
   "urine calcium", "U-Ca",
   "urinary calcium/creatinine ratio", "U-Ca",
   "urinary calcium-creatinine ratio", "U-Ca",
   "urine calcium/creatinine ratio", "U-Ca",
   "Urinary calcium/creatinine ratios", "U-Ca",
   "24-hour urinary calcium", "U-Ca",
   "24-hour urine calcium", "U-Ca",
   "calcium/creatinine ratio", "U-Ca",
   "urinary Ca", "U-Ca",
   "urine calcium excretion", "U-Ca",
   "maternal urinary Ca/Cr ratio", "U-Ca",
   "bone calcium", "Bone-Ca",
   "physical activity", "Physical function",
   "health and physical-activity data", "Physical function",
   "physical performance and activity", "Physical function",
   "Short Physical Performance Battery (SPPB)", "Physical function",
   "physcial performance", "Physical function",
   "physcial activity", "Physical function",
   "physical function", "Physical function",
   "short physical performance test", "Physical function",
   "muscle strength", "Physical function",
   "muscle function", "Physical function",
   "Upper and lower extremity muscle strength and power", "Physical function",
   "musculoskeletal function", "Physical function",
   "Isometric muscular strength", "Physical function",
   "quadriceps muscle strength", "Physical function",
   "Timed Up and Go and five sit-to-stand tests", "Physical function",
   "dynamic balance (four square step test)", "Physical function",
   "walk test", "Physical function",
   "endurance (shuttle walk)", "Physical function",
   "time needed to perform the TUG test", "Physical function",
   "short physical performance test", "Physical function",
   "Modified Cooper test", "Physical function",
   "chair-rising tests", "Physical function",
   "handgrip strength", "Physical function",
   "Upper and lower extremity muscle strength and power", "Physical function",
   "grip strength", "Physical function",
   "isometric strength", "Physical function",
   "dynamic strength", "Physical function",
   "quadriceps strength", "Physical function",
   "quadriceps muscle strength", "Physical function",
   "knee extension strength", "Physical function",
   "timed up and go", "Physical function",
   "timed 25 foot walk", "Physical function",
   "timed 10 foot tandem walk", "Physical function",
   "single-leg stance time", "Physical function",
   "8-foot walk time", "Physical function",
   "Timed Up and Go and five sit-to-stand tests", "Physical function",
   "gait (timed-up-and-go)", "Physical function",
   "gait speed", "Physical function",
   "body sway", "Physical function",
   "balance", "Physical function",
   "vertical jump height", "Physical function",
   "vertical-jump", "Physical function",
   "jump height", "Physical function",
   "chair-stand", "Physical function",
   "death", "mortality",
   "deaths", "mortality",
   "postural stability", "Physical function",
   "knee flexion and extension", "Physical function",
   "standing with eyes closed", "Physical function",
   "standing with eyes open", "Physical function",
   "stair climbing power,", "Physical function",
   "dynamic balance (four square step test)", "Physical function",
   "10 m sprint times", "Physical function",
   "time needed to perform the TUG test", "Physical function",
   "Timed Get Up and Go", "Physical function",
   "mobility", "Physical function",
   "balance (degree of trunk angular displacement and angular velocity during a postural task)", "Physical function",
   "balance (degree of trunk angular displacement and angular velocity during a dynamic task)", "Physical function",
   "falls", "Physical function-falls",
   "fallers", "Physical function-falls",
   "rate of falls", "Physical function-falls",
   "number of falls", "Physical function-falls",
   "injurious falls", "Physical function-falls",
   "number of fallers", "Physical function-falls",
   "number of injured fallers", "Physical function-falls",
   "hip fractures" , "fractures",
   "fracture incidence" , "fractures",
   "other fractures" , "fractures",
   "fracture risk" , "fractures",
   "all-new fractures" , "fractures",
   "fractures confirmed by radiography" , "fractures",
   "high sensitivity C-reactive protein" , "CRP",
   "immunoreactive PTH" , "CRP",
   "C-reactive protein" , "CRP",
   "high-sensitivity C-reactive protein (hsCRP)" , "CRP",
   "high-sensitivity C-reactive protein" , "CRP",
   "highly sensitive C-reactive protein (hsCRP)" , "CRP",
   "highly sensitive C-reactive protein" , "CRP",
   "hs-CRP" , "CRP",
   "high-sensitivity C-reactive protein (hsCRP)" , "CRP",
   "high sensitive CRP" , "CRP",
   "high-sensitivity CRP" , "CRP",
   "highly sensitive C-reactive protein (hsCRP)" , "CRP",
   "iPTH" , "PTH",
   "immunoreactive PTH" , "PTH",
   "IRMA-PTH" , "PTH",
   "maybe PTH" , "PTH",
   "PTH(1-84) secretion" , "PTH",
   "parathyroid hormone" , "PTH",
   "BMD - whole body" , "BMD",
   "BMD - femoral neck" , "BMD",
   "nondominant forearm BMD" , "BMD",
   "maybe BMD" , "BMD",
   "BMD and many more" , "BMD",
   "BMD lumbar spine" , "BMD",
   "BMD - femoral neck, spine, whole body" , "BMD",
   "BMD - spine, femoral neck" , "BMD",
   "BMD at various sites" , "BMD",
   "Radial volumetric BMD" , "BMD",
   "BMD - hip" , "BMD",
   "BMD - Lumbar spine (L1-L4)" , "BMD",
   "BMD - left proximal femur" , "BMD",
   "BMD - total body" , "BMD",
   "BMD - spine" , "BMD",
   "BMD - left femoral neck" , "BMD",
   "BMD - right femoral neck" , "BMD",
   "BMD - femoral trochanter" , "BMD",
   "BMD - distal radius" , "BMD",
   "BMD - lumbar" , "BMD",
   "BMD - Lumbar (L1-4)" , "BMD",
   "BMD - lumbar spine" , "BMD",
   "BMD - total hip" , "BMD",
   "BMD - distal" , "BMD",
   "BMD - 33% radius" , "BMD",
   "fasting glucose" , "glucose",
   "fasting plasma glucose" , "glucose",
   "plasma glucose" , "glucose",
   "Fasting serum glucose (FSG)" , "glucose",
   "oral glucose tolerance testing" , "glucose",
   "glucose levels on oral glucose tolerance test" , "glucose",
   "2-hour glucose" , "glucose",
   "blood glucose" , "glucose",
   "fasting plasma glucose (FPG)" , "glucose",
   "post-prandial blood glucose (PPG)" , "glucose",
   "glucose tolerance" , "glucose",
   "serum glucose" , "glucose",
   "Glycemic status" , "glucose",
   "fasting insulin", "insulin",
   "serum insulin", "insulin",
   "2-hour insulin", "insulin",
   "inslut-sensitiivy", "insulin sensitivity/resistance",
   "insulin sensitivity", "insulin sensitivity/resistance",
   "homeostasis model of assessment - insulin resistance (HOMA-IR)", "insulin sensitivity/resistance",
   "homeostatic model of assessment index (HOMA-IR)", "insulin sensitivity/resistance",
   "insulin resistance", "insulin sensitivity/resistance",
   "HOMA-ß", "insulin sensitivity/resistance",
   "HOMA-IR", "insulin sensitivity/resistance",
   "first phase incremental AUC insulin", "insulin sensitivity/resistance",
   "insulin secretory burst mass", "insulin sensitivity/resistance",
   "insulin secretion", "insulin sensitivity/resistance",
   "obstetric and other neonatal outcomes, and maternal homeostasis model assessment of insulin resistance", "insulin sensitivity/resistance",
   "Quantitative Insulin Sensitivity Check Index (QUICKI)", "insulin sensitivity/resistance",
   "insulin daily dose", "insulin sensitivity/resistance",
   "insulin action (Si)", "insulin sensitivity/resistance",
   "Quantitative Insulin Sensitivity Check Index", "insulin sensitivity/resistance",
   "acute insulin response", "insulin sensitivity/resistance",
   "HbA1C", "HbA1c",
   # "", "",
   # "", "",
   # "", "",
   "CRP", "inflammation",
   "Physical function-falls", "Physical function",
   "fasting serum parathyroid hormone" , "PTH"
))


  # de-granularize outcomes
for(i in 1:nrow(new_names)) {
   outs$Outcomes[outs$Outcomes %in% new_names[i,1]] = new_names[i,2]
}

outs$dup = duplicated(outs$Outcomes)





outs2 = tibble(outcome=character(0), rids=character(0), n=numeric(0), studies=numeric(0))
i=1
for(z in 1:nrow(outs)) {
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
for(i in 1:nrow(outs2)) {
   outs2$studies[i] = length(unique(str_split(outs2$rids[i], ",")[[1]]))
}
outs2 = arrange(outs2, desc(n))
View(outs2)
fname = paste0(project_path, "/outcomes2.csv")
write.table(outs2, file=fname, sep=",")

