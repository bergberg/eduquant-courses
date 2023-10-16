summarise_binom_rate <-
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
           avg = "avg",
           type = "highest") {
    
    if ("dfci" %in% names(data)) {
      abort("no dfci name already ok")
    }
    
    name_str <- rlang::as_name(enquo(name))
    
    data |> 
      group_by({{t}}, .add=TRUE) |> 
      summarise(
        dfci = ci_fun(sum({{indicator}}), {{count}}, type=type, conf.level=conf.level),
        "{{name}}" := dfci[[ci_point]],
        "{{name}}_upper" := dfci[[ci_upper]],
        "{{name}}_lower" := dfci[[ci_lower]],
        .groups = "keep"
      ) |> 
      select(-dfci) |> 
      ungroup({{t}}) |> 
      mutate(
        across(all_of(name_str), \(x)broom::tidy(t.test(x)), .names = "{.col}_avg_ttest"),
        across(all_of(paste0(name_str, "_avg_ttest")), c(
          avg = \(x)x$estimate,
          avg_lower = \(x)(x$conf.low- x$estimate)*sqrt(n_overlap)+x$estimate,
          avg_upper = \(x)(x$conf.high - x$estimate)*sqrt(n_overlap)+x$estimate
          ), .names = paste0(name_str,"_{.fn}")),
        # "{{name}}_avg" := pluck({{name}}
      ) |> 
      select(-all_of(paste0(name_str,"_avg_ttest")))
        
             
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
    if (length(data_group_vars)>0) {
      p <- ggplot(data,aes(x={{t}}, color=.data[[data_group_vars[[1]]]], fill=.data[[data_group_vars[[1]]]]))
    } else{       p <- ggplot(data,aes(x={{t}}))}
    
    data_labels <- 
      summarize(
        data, 
        across(ends_with(avg_postfix), first),
        "{{t}}" := max({{t}}),
        .groups="drop"
      )
    
    facet_vars <- data_group_vars[-1]
    p <- p +
      list(
        geom_line(
          alpha=alpha,
          linewidth = 0.4,
          aes(y= {{name}})),
        geom_ribbon(
          alpha = alpha*.33,
          linewidth=0.024,
          aes(
            ymin = .data[[paste0(name_str, lower_postfix)]],
            ymax = .data[[paste0(name_str, upper_postfix)]])),
        geom_line(
          alpha=0.9,
          linewidth=1,
          linetype="dashed",
          aes(y = .data[[paste0(name_str, avg_postfix)]]))
        # ,
        # geom_ribbon(
        #   color=NA,
        #   alpha=alpha*.33,
        #   aes(
        #     ymin = .data[[paste0(name_str, avg_postfix, lower_postfix)]],
        #     ymax = .data[[paste0(name_str, avg_postfix, upper_postfix)]])
        # )
      ) * (blend("multiply")  ) +
      geom_label_repel(
        data=data_labels,
        fill="white",
        alpha=0.95,
        aes(
          x={{t}},
          y=.data[[paste0(name_str, avg_postfix)]],
          label = scales::label_percent(accuracy = 0.1)(.data[[paste0(name_str, avg_postfix)]]))
      ) +
      scale_y_continuous(labels = scales::label_percent(accuracy = 1))
    if (length(facet_vars)>0) {
      p <- p+facet_wrap(facet_vars)
    }
    
    return(p)
  }
