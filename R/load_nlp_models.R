#' Load NLP Models
#' 
#' Loads a set of OpenNLP models according to an optional character vector of entities.
#' @param entities Character vector of entities. 
#' @return A list of openNLP models
#' @examples 
#' a <- load_nlp_models(c("sentence","word","POS","person","organization","location","date","time","percentage"))

load_nlp_models <- function(entities){
  library("openNLP")
  library("XML")
  library("NLP")
  
  pipeline <- list()
  for(i in 1:length(entities)){
    if(entities[i]=="sentence"){
      pipeline[[length(pipeline)+1]] <- Maxent_Sent_Token_Annotator()
      names(pipeline)[length(pipeline)] <- "sentence"
    } else if(entities[i]=="word"){
      pipeline[[length(pipeline)+1]] <- Maxent_Word_Token_Annotator()
      names(pipeline)[length(pipeline)] <- "word"
    } else if(entities[i]=="POS"){
      pipeline[[length(pipeline)+1]] <- Maxent_POS_Tag_Annotator()
      names(pipeline)[length(pipeline)] <- "POS"
    } else {
      pipeline[[length(pipeline)+1]] <- Maxent_Entity_Annotator(kind = entities[i])
      names(pipeline)[length(pipeline)] <- "person"
    }
  }
  return(pipeline)
}
