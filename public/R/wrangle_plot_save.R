# ---- write_gg
write_gg <- function(plot, path = get_post_path(), width = 580, height = 426) {
  if (!require(ggplot2, quietly = TRUE)) {
    stop("`ggplot2` package not found.")
  }

  out <- plot +
    ggplot2::theme(axis.text = ggplot2::element_text(size = 7),
                   legend.position = "none", 
                   plot.caption = ggplot2::element_blank(),
                   plot.subtitle = ggplot2::element_blank(),
                   plot.title = ggplot2::element_blank())
  
  dpi <- 125
  width <- width * 1.5 / dpi
  height <- height * 1.5 / dpi
  
  ggplot2::ggsave(filename = "featured.png", plot = out, path = path, 
                  width = width, height = height, dpi = dpi)
}

get_post_path <- function() {
  depends <- c("here", "rmarkdown", "stringr")
  success <- vector(mode = "logical", length = length(depends))
  for (i in seq_along(depends)) {
    success[[i]] <- require(depends[[i]], quietly = TRUE, character.only = TRUE)
  }
  if (!all(success)) {
    stop(paste(depends[!success], "packages not found."))
  }
  post_title <- rmarkdown::metadata$title
  clean_title <- stringr::str_to_lower(stringr::str_replace_all(post_title, "\\s", "-"))
  here::here(stringr::str_glue("content/post/{clean_title}/"))
}


# ---- wrangle_plot_save
wrangle_plot_save <- function(bench_marks, .n, .mem, .title, ...) {
  depends <- c("dplyr", "tidyr", "stringr", "ggplot2", "extrafont")
  success <- vector(mode = "logical", length = length(depends))
  for (i in seq_along(depends)) {
    success[[i]] <- require(depends[[i]], quietly = TRUE, character.only = TRUE)
  }
  if (!all(success)) {
    stop(paste(depends[!success], "packages not found."))
  }
  
  extrafont::loadfonts("win", quiet = TRUE)

  df <- bench_marks %>% 
    mutate(expression = as.character(expression)) %>% 
    mutate(expression = if_else(
      str_detect(expression, "py_run_string"),
      str_extract(expression, '(?<=").*?(?=")'),
      expression)
    ) %>%
    mutate(framework = case_when(
      str_detect(expression, "^(np\\.|numpy_)") ~ "NumPy",
      str_detect(expression, "^numba_") ~ "Numba",
      str_detect(expression, "^numba_") ~ "Numba Parallel",
      str_detect(expression, "^(cp\\.|cupy_)") ~ "CuPy",
      str_detect(expression, "^r?cpp_arma_") ~ "RcppArmadillo",
      str_detect(expression, "^r?cpp_par") ~ "RcppParallel",
      str_detect(expression, "^r?cpp_") ~ "Rcpp",
      str_detect(expression, "^r_") ~ "Base R",
      TRUE ~ "Base R"
      )
    ) %>%
    mutate(expression = str_remove(expression, "(?<=\\().*?(?=\\))")) %>%
    mutate(framework = str_glue("  {framework}  ")) %>% 
    mutate(is_parallel = str_detect(expression, "_par_")) %>% 
    mutate(is_gpu = str_detect(expression, "cupy_")) %>% 
    unnest() %>%
    group_by(expression) %>%
    mutate(med = median(as.numeric(time))) %>%
    ungroup() %>%
    arrange(desc(med)) %>%
    mutate(Expression = as_factor(expression)) %>%
    arrange(med) %>%
    # mutate(expression = as_factor(expression)) %>%
    mutate(framework = as_factor(framework)) %>%
    rename(Time = time)
  
  out <- df %>% 
    ggplot(aes(x = Expression, y = Time)) +
      ggbeeswarm::geom_beeswarm(aes(fill = framework), 
                                alpha = 0.8, shape = 21, size = 4, cex = 2) +
      scale_fill_viridis_d() +
      bench::scale_y_bench_time(base = NULL) +
      guides(fill = guide_legend(override.aes = list(size = 5))) +
      coord_flip() +
      theme_minimal(base_size = 18, base_family = "Palatino Linotype") +
      theme(axis.title = element_blank(),
            axis.text.y = element_text(family = "Fira Code Retina", size = 14, 
                                       colour = "black",
                                       margin = margin(0, 0, 0, 0, "lines")),
            axis.text.x = element_text(size = 12, colour = "black",
                                       margin = margin(0, 0, 0, 0, "lines")),
            legend.position = "bottom", legend.title = element_blank(),
            plot.title = element_text(face = "bold"),
            plot.subtitle = element_text(size = 12, face = "italic"),
            plot.caption = element_text(family = "Fira Code Retina", size = 14, 
                                        face = "bold"),
            panel.spacing = unit(0, "lines"),
            panel.border = element_rect(colour = NA, fill = NA, size = 0)) +
      labs(title = .title, 
           subtitle = str_glue("n = {n} ({mem})"),
           caption = "knapply.com")

  write_gg(plot = out, ...)

  out
}

# ---- validate_results
validate_results <- function(control_res, ..., tol = sqrt(.Machine$double.eps)) {
  dots <- list(`Base R` = control_res, ...)
  res <- vapply(dots, eval, double(1))
  
  stopifnot(all(vapply(res, all.equal, FUN.VALUE = logical(1), 
                       control_res, tolerance = tol)))

  res_df <- tibble::tibble(Method = names(res), Result = res)
  kableExtra::kable_styling(knitr::kable(res_df), 
                            bootstrap_options = "condensed",
                            full_width = FALSE)
}

# ---- validate_data
validate_data <- function(control_data, ..., tol = 1e-6) {
  dots <- list(`Original R Data` = control_data, ...)
  res <- vapply(lapply(dots, as.vector), all.equal, FUN.VALUE = logical(1), 
                control_data, tolerance = tol)
  
  stopifnot(all(res))

  res_df <- tibble::tibble(Method = names(res), `Still Intact?` = res)
  kableExtra::kable_styling(knitr::kable(res_df), 
                            bootstrap_options = "condensed",
                            full_width = FALSE)
}

# ---- as_href
r_as_href <- function(pkg_foo, topic = NULL, drop_pkg = TRUE) {
  pkg <- stringr::str_extract(pkg_foo, "^.*?(?=::)")
  foo <- stringr::str_extract(pkg_foo, "(?<=::).*?(?=\\(\\)$)")
  if (!is.null(topic)) {
    foo <- topic
  }
  href <- stringr::str_glue("https://www.rdocumentation.org/packages/{pkg}/topics/{foo}")
  if (drop_pkg) {
    pkg_foo <- stringr::str_remove(pkg_foo, "^.*?::")
  }
  stringr::str_glue("[`{pkg_foo}`]({href})")
}

py_as_href <- function(pkg_foo) {
  pkg <- stringr::str_extract(pkg_foo, "^.*?(?=\\.)")
  bare <- stringr::str_remove(pkg_foo, "\\(\\)$")
  foo <- stringr::str_extract(bare, "(?<=\\.).*?$")
  if (pkg == "np") {
    href <- stringr::str_glue("https://docs.scipy.org/doc/numpy/reference/generated/numpy.{foo}.html")
  } else if (pkg == "cp") {
    href <- stringr::str_glue("https://docs-cupy.chainer.org/en/stable/reference/generated/cupy.{foo}.html")
  } else {
    href <- stringr::str_glue("https://docs.python.org/3/library/{pkg}.html#{bare}")
  }
  stringr::str_glue("[`{pkg_foo}`]({href})")
}

