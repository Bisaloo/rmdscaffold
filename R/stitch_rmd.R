
#' @examples
#' test <- stitch_rmd(
#'   "inst/example/load_data.Rmd",
#'   "inst/example/plot_data.Rmd"
#' )
#' 
#' test <- stitch_rmd(
#'   "inst/example/load_data.Rmd",
#'   "inst/example/aggregate_data.Rmd",
#'   "inst/example/plot_data.Rmd"
#' )
#' tinkr::to_md(test)

stitch_rmd <- function(...) {
  
  args <- list(...)
  
  res <- list(
    yaml = ""
  )

  s <- lapply(args, function(x) tinkr::yarn$new(x)$body)
  s <- lapply(s,    function(x) xml2::as_list(x)$document)

  res$body <- xml2::as_xml_document(list("document" = do.call(c, s)))
  
  xml_attr(res$body, "xmlns") = "http://commonmark.org/xml/1.0"

  return(res)

}