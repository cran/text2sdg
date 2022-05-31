## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=7, fig.height=4
)
library(text2sdg)


## ---- eval=FALSE--------------------------------------------------------------
#  # detecting SDGs in projects
#  hits_default <- detect_sdg(projects)
#  hits_default

## ---- echo = F----------------------------------------------------------------
options(tibble.print_min = 5)

## -----------------------------------------------------------------------------
# detecting SDGs using all available query systems
hits_all <- detect_sdg(projects, 
                       system = c("Aurora", "Elsevier", "SIRIS", "SDSN", "OSDG"))

# count hits of systems
table(hits_all$system)

## ---- echo = F----------------------------------------------------------------
options(tibble.print_min = 10)

## -----------------------------------------------------------------------------
# detecting only for SDGs 1 to 5
hits_sdg_subset <- detect_sdg(projects, sdgs = 1:5)
hits_sdg_subset

## -----------------------------------------------------------------------------
# return documents output format
detect_sdg(projects, output = "documents")

## -----------------------------------------------------------------------------
# definition of query set
my_queries <- tibble::tibble(system = "my_system",
                              query = c("theory", "analysis OR analyses OR analyzed", "study AND hypothesis"),
                              sdg = c(3,7,7))

# return documents output format
detect_any(text = projects, 
           queries = my_queries)

## -----------------------------------------------------------------------------
# show stacked barplot of hits
plot_sdg(hits_all)

## -----------------------------------------------------------------------------
# show normalized, side-by-side barplot of hits
plot_sdg(hits_all, 
         sdg_titles = TRUE,
         normalize = "systems", 
         position = "dodge")

## -----------------------------------------------------------------------------
# show system hits in separate panels
plot_sdg(hits_all) + 
  ggplot2::facet_wrap(~system, ncol= 1, scales = "free_y")

## -----------------------------------------------------------------------------
# evaluate correspondence between systems 
crosstab_sdg(hits_all) %>% round(2)

## -----------------------------------------------------------------------------
# evaluate correspondence between systems 
crosstab_sdg(hits_all, compare = "sdgs") %>% round(2)

