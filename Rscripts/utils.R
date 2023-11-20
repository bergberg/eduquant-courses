summarise_binom_rate_ci <-
  function(data,
           indicator,
           count = n(),
           t = t,
           name,
           ci_fun = binom::binom.bayes,
           ci_point = "mean",
           ci_upper = "upper",
           ci_lower = "lower",
           conf.level = 0.68,
           n_overlap = 12,
           type = "highest") {
    name_str <- rlang::as_name(enquo(name))

    data |>
      group_by({{ t }}, .add = TRUE) |>
      summarise(
        "{{name}}_df" = ci_fun(sum({{ indicator }}), {{ count }}, type = type, conf.level = conf.level),
        "{{name}}" := `{{name}}_df`[[ci_point]],
        "{{name}}_upper" := `{{name}}_df`[[ci_upper]],
        "{{name}}_lower" := `{{name}}_df`[[ci_lower]],
        .groups = "keep"
      ) |>
      select(-`{{name}}_df`) |>
      ungroup({{ t }}) |>  mutate(
        across(all_of(name_str), \(x)broom::tidy(t.test(x)), .names = "{.col}_avg_ttest"),
        across(all_of(paste0(name_str, "_avg_ttest")), c(
          avg = \(x)x$estimate,
          avg_lower = \(x)x$estimate - (x$estimate - x$conf.low) * sqrt(n_overlap),
          avg_upper = \(x)x$estimate + (x$conf.high - x$estimate) * sqrt(n_overlap)
        ), .names = paste0(name_str, "_{.fn}"))
      ) |>
        select(-all_of(paste0(name_str, "_avg_ttest")))
  }

summarise_binom_rate_ci_weight <-
  function(data,
           indicator,
           count = n(),
           weight,
           t = t,
           name,
           ci_fun = binom::binom.bayes,
           ci_point = "mean",
           ci_upper = "upper",
           ci_lower = "lower",
           conf.level = 0.68,
           n_overlap = 12,
           type = "highest") {
    name_str <- rlang::as_name(enquo(name))
    
    data |>
      group_by({{ t }}, .add = TRUE) |>
      summarise(
        "{{name}}_df" = ci_fun(sum({{ indicator }}), {{ count }}, type = type, conf.level = conf.level),
        "{{name}}" := mean({{weight}})*`{{name}}_df`[[ci_point]],
        "{{name}}_upper" := mean({{weight}})*`{{name}}_df`[[ci_upper]],
        "{{name}}_lower" := mean({{weight}})*`{{name}}_df`[[ci_lower]],
        .groups = "keep"
      ) |>
      select(-`{{name}}_df`) |>
      ungroup({{ t }}) |>  mutate(
        across(all_of(name_str), \(x)broom::tidy(t.test(x)), .names = "{.col}_avg_ttest"),
        across(all_of(paste0(name_str, "_avg_ttest")), c(
          avg = \(x)x$estimate,
          avg_lower = \(x)x$estimate - (x$estimate - x$conf.low) * sqrt(n_overlap),
          avg_upper = \(x)x$estimate + (x$conf.high - x$estimate) * sqrt(n_overlap)
        ), .names = paste0(name_str, "_{.fn}"))
      ) |>
      select(-all_of(paste0(name_str, "_avg_ttest")))
  }

summarise_binom_rate <-
  function(data,
           indicator,
           name,
           t,
           count = n()) {
    name_str <- rlang::as_name(enquo(name))

    data |>
      group_by({{ t }}, .add = TRUE) |>
      summarise(
        "{{name}}" := sum({{ indicator }}) / {{ count }},
        .groups = "keep"
      ) |>
      ungroup({{ t }}) 
  }

summarise_binom_rate_avg <-
  function(data,
           indicator,
           name,
           t,
           count = n(),
           n_overlap = 12) {
    
    
    data |>
      group_by({{ t }}, .add = TRUE) |>
      summarise(
        "{{name}}_rate_t" = sum({{ indicator }}) / {{ count }},
        .groups = "keep"
      ) |>
      ungroup({{ t }}) |>
      summarise(
        "{{name}}" := mean(`{{name}}_rate_t`),
        .groups = "keep"
      )
  }

ggplot_rate_series <-
  function(data,
           t = t,
           name,
           upper_postfix = "_upper",
           lower_postfix = "_lower",
           avg_postfix = "_avg",
           alpha = 0.33) {
    name_str <- rlang::as_name(enquo(name))

    data_group_vars <- group_vars(data)
    if (length(data_group_vars) > 0) {
      p <- ggplot(data, aes(x = {{ t }}, color = .data[[data_group_vars[[1]]]], fill = .data[[data_group_vars[[1]]]]))
    } else {
      p <- ggplot(data, aes(x = {{ t }}))
    }



    facet_vars <- data_group_vars[-1]
    lgeom <- list(
      geom_line(
        alpha = alpha,
        linewidth = 0.4,
        aes(y = {{ name }})
      ),
      geom_ribbon(
        alpha = alpha * .33,
        linewidth = 0.024,
        aes(
          ymin = .data[[paste0(name_str, lower_postfix)]],
          ymax = .data[[paste0(name_str, upper_postfix)]]
        )
      ))
    if (avg_postfix!=""&&!is.null(avg_postfix)) {
      
    lgeom <- 
      c(lgeom,
      list(
        geom_line(
        alpha = 0.9,
        linewidth = 1,
        linetype = "dashed",
        aes(y = .data[[paste0(name_str, avg_postfix)]])
      ),
      geom_line(
        alpha = 0.9,
        linewidth = 0.5,
        linetype="dashed",
        aes(
          y = .data[[paste0(name_str,avg_postfix, upper_postfix)]]
        )
      )
      )

    )
    data_labels <-
      summarize(
        data,
        across(contains(avg_postfix), first),
        "{{t}}" := max({{ t }}),
        .groups = "drop"
      )
    p <- p +
      lgeom * (blend("multiply")) +
      geom_label_repel(
        data = data_labels,
        fill = "white",
        alpha = 0.95,
        size=9/.pt,
        aes(
          x = {{ t }},
          y = .data[[paste0(name_str, avg_postfix)]],
          label = scales::label_percent(accuracy = 0.1)(.data[[paste0(name_str, avg_postfix)]]),
        ),
        nudge_x = 8
      ) + scale_y_continuous(labels = scales::label_percent(accuracy = 1))
    } else {
      p <- p +
        lgeom * (blend("multiply")) +
        scale_y_continuous(labels = scales::label_percent(accuracy = 1))
    }
    if (length(facet_vars) > 0) {
      p <- p + facet_wrap(facet_vars)
    }

    return(p)
  }
