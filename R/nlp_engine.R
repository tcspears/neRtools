#' NLP Engine
#' 
#' Builds an Annotated Plaintext Document from a character vector input.
#' @param input A character vector of text to be analysed.
#' @param model.list A model list, produced using load_nlp_models.

nlp_engine <- function(input,model.list){
  s <- as.String(input)
  s_annotations <- annotate(s,model.list)
  s_doc <- AnnotatedPlainTextDocument(s, s_annotations)
  return(s_doc)
}