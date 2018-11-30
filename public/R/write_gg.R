# ---- write_gg
write_gg <- function(plot, path = here::here(glue::glue("content/post/{rmarkdown::metadata$title}/")),
                     width = 580, height = 426, text_factor = 1) {
  if (!require(ggplot2, quietly = TRUE)) {
    stop("`ggplot2` package not found.")
  }

  out <- plot +
    ggplot2::theme(axis.text = ggplot2::element_text(size = 7),
                   legend.position = "none", 
                   plot.caption = ggplot2::element_blank(),
                   plot.subtitle = ggplot2::element_blank(),
                   plot.title = ggplot2::element_blank())
  
  dpi <- text_factor * 125
  width <- width * 1.5 / dpi
  height <- height * 1.5 / dpi
  
  ggplot2::ggsave(filename = "featured.png", plot = out, path = path, 
                  width = width, height = height, dpi = dpi)
}



# ---- wrangle_plot_save
wrangle_plot_save <- function(bench_marks, .n, .mem) {
  depends <- c("dplyr", "tidyr", "stringr", "ggplot2")
  success <- vector(mode = "logical", length = length(depends))

  for (i in seq_along(depends)) {
    success[[i]] <- require(depends[[i]], quietly = TRUE, character.only = TRUE)
  }

  if (!all(success)) {
    stop(paste(depends[!success], "packages not found."))
  }

  out <- bench_marks %>% 
    mutate(expression = as.character(expression)) %>% 
    mutate(expression = if_else(
      str_detect(expression, "py_run_string"),
      str_extract(expression, '(?<=").*?(?=")'),
      expression)
    ) %>%
    mutate(expression = str_remove(expression, "(?<=\\().*?(?=\\))")) %>% 
    mutate(framework = case_when(
      str_detect(expression, "^numpy_") ~ "NumPy",
      str_detect(expression, "^numba_") ~ "NumPy w/ Numba",
      str_detect(expression, "^cupy_") ~ "CuPy",
      str_detect(expression, "^cpp_") ~ "Rcpp",
      str_detect(expression, "^r_") ~ "Base R"
      )
    ) %>%
    mutate(is_parallel = str_detect(expression, "_par_")) %>% 
    mutate(is_gpu = str_detect(expression, "cupy_")) %>% 
    unnest() %>%
    group_by(expression) %>%
    mutate(med = median(as.numeric(time))) %>%
    ungroup() %>%
    arrange(desc(med)) %>%
    mutate(Expression = as_factor(expression)) %>%
    arrange(med) %>%
    mutate(expression = as_factor(expression)) %>%
    rename(Time = time) %>% 
    ggplot(aes(x = Expression, y = Time)) +
      stat_ydensity(aes(fill = framework), color = NA, scale = "width", bw = 0.01, 
                    trim = FALSE) +
      scale_fill_viridis_d() +
      # scale_fill_brewer(palette = "Spectral") +
      # guides(fill = guide_legend(ncol = 2, override.aes = list(size = 3))) +
      coord_flip() +
      theme_minimal(base_size = 16, base_family = "serif") +
      theme(axis.title.x = element_text(size = 10),
            axis.title.y = element_blank(),
            axis.text.y = element_text(family = "mono", size = 14, face = "bold"),
            legend.position = "bottom", legend.title = element_blank(),
            legend.text = element_text(size = 12),
            legend.key.size = unit(1.5, "lines"), 
            plot.title = element_text(face = "bold"),
            plot.subtitle = element_text(face = "italic"),
            plot.caption = element_text(family = "mono", size = 16, face = "bold")) +
      labs(title = "Benchmarks Shootout: Statistical Mode", 
           subtitle = glue::glue(
             "n = {n} ({mem})"
             ), 
           caption = "knapply.com")
  
  write_gg(plot = out)
  
  out
}
