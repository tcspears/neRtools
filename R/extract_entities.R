#' Extract Shared Entities
#' 
#' Extracts a set of named entities from a text input according to a set of NLP models.
#' @param input A character vector of text to be analysed.
#' @param model.list A model list, produced using load_nlp_models.

extract_entities <- function(input,model.list){
  doc <- nlp_engine(input,model.list)
  s <- doc$content
  d <- annotations(doc)[[1]]
  k <- sapply(d$features, `[[`, "kind")
  out <- list()
  for(i in 1:length(names(model.list))){
    if(names(model.list)[i]=="POS"){
      tagged <- tagged_words(doc)
      POS.list <- list()
      POS.names <- unique(regmatches(tagged,m=regexpr("([^/]+$)",tagged),invert=FALSE))
      for(j in 1:length(POS.names)){
        words.dirty <- unique(tagged[grep(paste("/",POS.names[j],"\\>",sep=""),tagged)])
        POS.list[[j]] <- sub(pattern="(\\/+[^/]+$)",replacement="",x=words.dirty)
        names(POS.list)[length(POS.list)] <- POS.names[j]
      }
      out[[length(out)+1]] <- POS.list
      names(out)[length(out)] <- names(model.list)[i]
    } else {
      if(names(model.list)[i] %in% k){
        out[[length(out)+1]] <- unique(s[d[k== names(model.list)[i]]])        
        names(out)[length(out)] <- names(model.list)[i]
      } else if(names(model.list)[i] %in% unique(d$type)){
        out[[length(out)+1]] <- unique(s[d[d$type == names(model.list)[i]]])
        names(out)[length(out)] <- names(model.list)[i]
      } else {
        out[[length(out)+1]] <- character(0)
        names(out)[length(out)] <- names(model.list)[i]
      }
    }
  }
  return(out)
}