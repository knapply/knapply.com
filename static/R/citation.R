title <- rmarkdown::metadata$title
index <- stringr::str_to_lower(stringr::str_replace_all(title, "\\s+", "-"))
author <- rmarkdown::metadata$author
date <- as.Date(rmarkdown::metadata$date)
year <- lubridate::year(date)
month <- months.Date(date, abbreviate = TRUE)
day <- lubridate::day(date)
citation_url <- rmarkdown::metadata$citation_url

print_citation <- function() {
  glue::glue(
    'Knapp, B. (<<year>>, <<month>>. <<day>>). <<title>>. Retrieved from <<citation_url>>',
    .open = "<<", .close = ">>"
    )
}

print_bibtex <- function() {
  glue::glue('Knapp, B. (<<year>>, <<month>>. <<day>>). <<title>>. Retrieved from <<citation_url>>',
           .open = "<<", .close = ">>")
  
  out <- glue::glue('@misc{<<index>>,
                      author = {Knapp, Brendan},
                      title  = {<<title>>},
                      url    = {<<citation_url>>},
                      year   = <<year>>,
                      month  = <<month>>,
                      day    = <<day>>,
                    }',
             .open = "<<", .close = ">>")
  cat(out)
}

print_citation_header <- function() {
  htmltools::HTML(
'<p><strong>Citation and <span class="math inline">\\(\\normalsize{\\textrm B} \\scriptsize{\\textrm{IB}} \\normalsize{\\TeX}\\)</span></strong></p>
<p>When using this post, please consider citing it.</p>'
  )
}


add_citation_info <- function() {
  print_citation()
  print_bibtex()
}
