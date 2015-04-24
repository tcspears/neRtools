#' Identify Shared Named Entities
#' 
#' Finds a set of named entities that are shared by two text inputs.
#' @param input1 The first character vector of text to be compared.
#' @param input2 The second character vector of text to be compared.
#' @param model.list A model list, produced using load_nlp_models.

shared_entities <- function(input1,input2,model.list){
  entities.1 <- extract_entities(input1,model.list)
  entities.2 <- extract_entities(input2,model.list)
  out <- list()
  for(i in 1:length(names(model.list))){
    if(names(model.list)[i]=="POS"){
      entities.1.POS <- entities.1[[i]]
      entities.2.POS <- entities.2[[i]]
      union.POS <- unique(union(names(entities.1.POS),names(entities.2.POS)))
      out.POS <- list()
      for(j in 1:length(union.POS)){
        if(is.null(unlist(entities.1.POS[names(entities.1.POS)==union.POS[j]]))||is.null(unlist(entities.2.POS[names(entities.2.POS)==union.POS[j]]))){
          out.POS[[length(out.POS)+1]] <- character(0)
          names(out.POS)[[length(out.POS)]] <- union.POS[j]
        } else {
          out.POS[[length(out.POS)+1]] <- intersect(unlist(entities.1.POS[names(entities.1.POS)==union.POS[j]]),unlist(entities.2.POS[names(entities.2.POS)==union.POS[j]]))
          names(out.POS)[[length(out.POS)]] <- union.POS[j]
        }
      }
      out[[length(out)+1]] <- out.POS
      names(out)[[length(out)]] <- names(model.list)[i]
    } else {
      out[[length(out)+1]] <- intersect(entities.1[[i]],entities.2[[i]])
      names(out)[[length(out)]] <- names(model.list)[i]      
    }
  }
  return(out)
}