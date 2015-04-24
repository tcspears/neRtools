#' NLP Engine
#' 
#' Builds an Annotated Plaintext Document from a character vector input.
#' @param input A character vector of text to be analysed.
#' @param model.list A model list, produced using load_nlp_models.
#' @return An annotated plaintext document for input.

nlp_engine <- function(input,model.list){
  s <- as.String(input)
  ann <- annotate(s,model.list)
  doc <- AnnotatedPlainTextDocument(s, ann)
  return(doc)
}