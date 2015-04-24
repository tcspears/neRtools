#' Contains Entities
#' 
#' Determines whether a text input contains any entities of a pre-specified type, and reports those entities. 
#' @param input A character vector of text to be analysed.
#' @param entities A character vector of named entities.
#' @param model.list A model list, produced using load_nlp_models.
#' @return A list containing: (a) a logical vector specifying whether each entity named in 'entities' was found in the text, and (b) a list of the identified entities.
#' @examples
#' a <- load_nlp_models(entities=c("sentence","word","POS","person"))
#' input <- "This is a test."
#' entities <- c("POS/NNP","person")
#' contains_entities(input,entities,model.list=a)

contains_entities <- function(input,entities,model.list){
  extracted <- extract_entities(input,model.list)
  contains.entity <- logical(0)
  entities.list <- list()
  POS.entities <- regmatches(entities,m=regexpr("([^/]+$)\\>",entities),invert=FALSE)
  for(i in 1:length(entities)){
    if(grepl("\\<POS/",entities[i])){
      if(length(extracted$"POS"[names(extracted$"POS")==POS.entities[i]])!=0){
        contains.entity[i] <- TRUE
        entities.list[i] <- extracted$"POS"[names(extracted$"POS")==POS.entities[i]]
        names(entities.list)[i] <- entities[i]
      } else {
        contains.entity[i] <- FALSE
      }
    } else {
      if(length(extracted[names(extracted)==entities[i]])!=0){
        contains.entity[i] <- TRUE
        entities.list[i] <- extracted[names(extracted)==entities[i]]
        names(entities.list)[i] <- entities[i]
      } else {
        contains.entity[i] <- FALSE
      }
    }
  }
  names(contains.entity) <- entities
  out <- list(contains.entity,entities.list)
  names(out) <- c("Contains Entity","Matching Entities")
  return(out)
}